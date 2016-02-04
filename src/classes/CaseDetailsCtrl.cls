public with sharing class CaseDetailsCtrl {

    Id actId {get;set;}
    public List<Account> acctLst {get;set;}
    public String strDOB {get;set;}
    public String strStartDate {get;set;}
    public String strEndDate {get;set;}
    public List<Contact> contLst {get;set;}
    public List<Case> caseLst {get;set;}
    public Case caseObj {get;set;}
    
    public List<Claim__c> claimLst {get;set;}
    public List<Attachment> attachemntLst{get;set;}
    public List<EmailMessage> emailMsgLst;
    public Boolean isEmailCase{get;set;}
    public Boolean isCMCaseType{get;set;}
    public Boolean isUMCaseType{get;set;}
    public List<Goal__c> goalLst {get;set;}
    public List<Goal__c> goalCloseLst {get;set;}
    public String selectedValue{get;set;}
    public Boolean isContactBillingAddr{get;set;}
    
    Id cmRTId = null; 
    Id umRTId = null;
    
    public CaseDetailsCtrl (ApexPages.StandardController controller) {       
         actId = apexpages.currentpage().getparameters().get('Id');
        System.debug('actId========>'+actId);
        
        caseObj =  [SELECT AccountId,Authorization_Id__c,Description,Type,CaseNumber,Category_Id__c,ownerId,Case_Queue__c,
                            ContactId,Id,IntStatus__c,Linked_Case__c,Origin, RecordTypeId,type_of_case__c,  
                            Status,Priority,Subject FROM Case  WHERE Id =:actId];
        getRecordTypes();                    
        getAcctLst();                    
    }
      
     public void getAcctLst() {
          if(caseObj != null && caseObj.AccountId != null){
                acctLst = [SELECT Age__c,DND__c,DOB__c,Name,Physician__c,Gender__c,Eligible__c,End_Date__c,
                        Start_Date__c,Helath_Plan__c,Helath_Plan_Id__c,Type,Disease__c,Id,profilePic__c 
                        FROM Account WHERE Id =: caseObj.AccountId];
        }
      }  
          
      public void getClaimDetails(){
          if(acctLst != null && acctLst.size()>0 && acctLst[0].Id != null){
              claimLst = [SELECT ClaimNumber__c,Claims__c,Claim_Name__c,Claim_Status__c,Id,Name FROM Claim__c WHERE Claims__c =: acctLst[0].Id];      
          }      
      }  
         
      public PageReference createGoal() {
        PageReference pf = new PageReference('/a0M/e?retURL=%2Fa0M%2Fo?core.apexpages.devmode.url=1');
        pf.getParameters().put('nooverride', '1');
        pf.setRedirect(true);       
        return pf;
    }  
      
    public void getMemberGoal() {        
        if(acctLst != null && acctLst.size()>0 && acctLst[0].Id != null){  
            goalLst = new List<Goal__c>([SELECT Goal_Status__c,Goal__c,Id,Intervention__c,Name,Outcome_Status2__c FROM Goal__c WHERE Goal__c =: acctLst[0].Id AND Goal_Status__c='Open']);
            goalCloseLst = new List<Goal__c>([SELECT Goal_Status__c,Goal__c,Id,Intervention__c,Name,Outcome_Status2__c FROM Goal__c WHERE Goal__c =: acctLst[0].Id AND Goal_Status__c='Closed']);
        }
    } 
       
    public void getContactBillingDetails(){
        isContactBillingAddr = false;
       getAcctLst();
     
        if(acctLst != null && acctLst.size()>0 && acctLst[0].Id != null){
               System.debug('acctLst[0].Id========>'+acctLst[0].Id);
            contLst=new List<Contact>([SELECT AccountId,MailingAddress,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet,MobilePhone,Name,Email,Phone FROM Contact WHERE AccountId =: acctLst[0].Id]);
             System.debug('contLst=== check=====>'+contLst);
            if(contLst != Null && contLst.size() > 0 && contLst[0].MailingStreet != null)
                isContactBillingAddr = true;            
            else          
                isContactBillingAddr = false;                  
            System.debug('isContactBillingAddr ===============>'+isContactBillingAddr);       
            }
            System.debug('isContactBillingAddr =====outer if==========>'+isContactBillingAddr); 
    }   
    public void dateFormat(List<Account> acctLst){
            DateTime dt = acctLst[0].DOB__c;
            strDOB = dt.format('dd MMM yyyy');
            dt = acctLst[0].Start_Date__c;
            strStartDate = dt.format('dd MMM yyyy');
            dt = acctLst[0].End_Date__c;
            strEndDate = dt.format('dd MMM yyyy');
    }  
     
    public void getCaseEmailAttachment(){
        isEmailCase = false;
        System.debug('isEmailCase=====11======>'+isEmailCase);
        emailMsgLst = [SELECT ActivityId,BccAddress,FromAddress,HasAttachment,Id,Subject,ToAddress FROM EmailMessage WHERE ParentId =:actId];//= '50055000002F4Oz']
        if(!emailMsgLst.isEmpty()){
        System.debug('isEmailCase====22=======>'+isEmailCase);
            attachemntLst = [SELECT Body, ContentType,Description,Id,Name,ParentId FROM Attachment WHERE ParentId =: emailMsgLst[0].Id]; //'02s550000004yYZAAY']
            if(!attachemntLst.isEmpty()){
                isEmailCase = true;
                System.debug('isEmailCase====33=====>'+isEmailCase+' <===ContentType===>'+attachemntLst[0].ContentType);
            }
        }
        else{
            isEmailCase = false;
        }
        System.debug('isEmailCase===========>'+isEmailCase);    
    }    
    
    public Attachment att {
        get {
            if (att == null) {
                att = [SELECT Body, ContentType,Description,Id,Name,ParentId FROM Attachment WHERE ParentId =: emailMsgLst[0].Id]; //'02s550000004yYZAAY']
                if(att != null)
                    isEmailCase = true;
                else
                    isEmailCase = false;    
            }
            System.debug('isEmailCase====from att =======>'+isEmailCase);
            return att;
        }
        public set;
    }
       
    public String pdf {
        get {
            return EncodingUtil.Base64Encode(att.body);
        }
    }   
   
   public void getCaseType(){
   
       if(caseObj.RecordTypeId == umRTId){ //'012550000004PCS'
           isCMCaseType = false;
           isUMCaseType = true;
       }
       else if(caseObj.RecordTypeId == cmRTId){ //'012550000004PXp'           
           isCMCaseType = true;
           isUMCaseType = false;
       }
   }   
  
      
   // Routing Rules
   public pagereference assignCaseToQueue() {   
       System.debug('selectedValue =========>'+selectedValue);   
       Map<String,Id> queueMap = new Map<String,Id>();
        for(Group grpObj:[select id,name from Group where type='Queue']){
            queueMap.put(grpObj.Name,grpObj.id);        
        }       
       if(selectedValue =='Incomplete Med Info'){
          caseObj.ownerId = queueMap.get('Nurse Inbox');
       }
       else if(selectedValue =='Nurse'){            
           caseObj.ownerId = queueMap.get('Nurse Inbox');
       }
       else if(selectedValue =='Medical Director'){         
           caseObj.ownerId = queueMap.get('Imaging Queue');
       }
       else if(selectedValue =='Denial Coordinator'){          
           caseObj.ownerId = queueMap.get('Coordinator Inbox');
       }  
       update caseObj;  
               
       Pagereference pg = new Pagereference('/apex/CarePlus_UMCases?id='+actId);
         pg.setRedirect(True);
         return pg;     
   }  
   
   public void getRecordTypes(){
    
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case;
        Map<String,Schema.RecordTypeInfo> rtMapByName = cfrSchema.getRecordTypeInfosByName();
        System.debug('rtMapByName==========>'+rtMapByName);
        Schema.RecordTypeInfo cmRTyName =  rtMapByName.get('CM_CaseManagement');
        System.debug('cmRTyName==========>'+cmRTyName);
        cmRTId = rtMapByName .get('CM_CaseManagement').getRecordTypeId();
        
        Schema.RecordTypeInfo umRTyName =  rtMapByName.get('Utilization Management');
        System.debug('umRTyName==========>'+umRTyName);
        umRTId = rtMapByName .get('Utilization Management').getRecordTypeId();
    
   }
}