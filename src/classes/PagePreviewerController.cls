public with sharing class PagePreviewerController{

    public Account acc{get;set;}
    public Case ca {get;set;}
    public List<Claim__c> claim {get;set;}
    public List<Prior_Authorization__c> pa {get;set;}
    public Boolean showTif {get;set;}
    public Boolean showRecords{get;set;}
    Id IDofthedocument;
    public PageReference pr{get;set;}
    public ID  caseId{get;set;}
    
  
    
     public PagePreviewerController(ApexPages.StandardController controller) {
         try{
         caseId =ApexPages.currentPage().getParameters().get('id');

          ca = [Select id,AccountId,Account.Id,CaseNumber from Case where id = :caseId  and AccountId !=null];
          showTif = false; 
          
           if(ca.id != null && ca.AccountId !=null){
                   acc= [select Id,name,Auth_Category__c,Auth_Type__c,Service_From_Date__c,Primary_Diag_Code__c,CPT_Code__c,Total_Units__c
                        from Account WHERE  Id= :ca.AccountId];
                        //showRecords =false;
                system.debug('Account Size'+ acc.id);
                pa = [Select id,name,Prior_Auth__c,Date_of_Approval__c,Decision__c,Prior_Auth_Desc__c,Prior_Auth_Ref__c
                        From Prior_Authorization__c where Prior_Auth__c =: ca.AccountId];
                        //showRecords = true;
                        //system.debug('Price Auth'+ pa[0].id);
               //pa = new List<Prior_Authorization__c>(); 
                //claim = new List<Claim__c>();       
                
                claim = [Select id ,name,Claims__c,ClaimNumber__c,Claim_Description__c,Claim_Name__c,Cost_of_Claim__c,Services_Provided__c 
                        FROM Claim__c where Claims__c =: ca.AccountId];
       
             }
         }
         Catch(Exception e){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,''+e));
             return;
         }
    }
    
      
    public ApexPages.pagereference loadTif(){        
        showTif = true;
        return null;
    }
    /*public List<Claim__c> getClaim(){
    claim = [Select id ,name,Claims__c,ClaimNumber__c,Claim_Description__c,Claim_Name__c,Cost_of_Claim__c,Services_Provided__c 
                FROM Claim__c where Claims__c =: ca.AccountId];
               // showRecords = true;
               // system.debug('Claim Size'+ claim[0].id);

               return claim;
        
    }
     public List<Prior_Authorization__c> getPa(){
     pa = [Select id,name,Prior_Auth__c,Date_of_Approval__c,Decision__c,Prior_Auth_Desc__c,Prior_Auth_Ref__c
                From Prior_Authorization__c where Prior_Auth__c =: ca.AccountId];
                //showRecords = true;
                system.debug('Price Auth'+ pa[0].id);
                return pa;
        
    }*/
    public PageReference SaveValues() {
       
           
         update(acc);
         
         // Step 1: Create a new Email
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
      // Step 2: Set list of people who should get the email
      List<String> sendTo = new List<String>{'infosys.healthcareplus@gmail.com'};
      mail.setToAddresses(sendTo);
    
      // Step 3: Set who the email is sent from
      mail.setReplyTo('noreply@salesforce.com');
      mail.setSenderDisplayName('New Case dispatch notification');
      
      // Step 4. Set email contents - you can use variables!
      mail.setSubject('A Case has been dispatched to the Coordinator. #'+ca.CaseNumber);
      String body = 'Dear Sir,<br/><br/><br/>';
      body += 'A Case has been dispatched to the Coordinator.<br/>';
      body += 'Routed Case number is #'+ca.CaseNumber+'<br/><br/><br/><br/>Thank You';
      
      mail.setHtmlBody(body);
    
      // Step 6: Send all emails in the master list
      Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
             
        /*pr = new PageReference('/'+acc.id);
        pr.setRedirect(true);
        return pr;*/

         return null;

   }


}