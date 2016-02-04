public with sharing class ViewMemberCtrl {


    Id actId {get;set;}
    public List<Account> acctLst {get;set;}
    public List<Claim__c> claimlist{get;set;}
    public List<Case> caselist {get;set;}
    public List<Sleep__c> sleeplist {get;set;}
    public List<Contact> cntLst {get;set;}
    public String strDOB {get;set;}
    public String strStartDate {get;set;}
    public String strEndDate {get;set;}
    public Account addAccountPill {get;set;}
    public Boolean isContactBillingAddr {get;set;}
    public Boolean isProfilePic {get;set;}
    
    public ViewMemberCtrl(ApexPages.StandardController controller) {
        
         actId = apexpages.currentpage().getparameters().get('Id');
        System.debug('actId========>'+actId);
        acctLst =  new List<Account>();
        claimlist = new List<Claim__c>();
        caselist = new List<Case>();
        sleeplist = new List<Sleep__c>();
        addAccountPill = new Account();
        isContactBillingAddr = false;
    }
    
    
     public void getAcctLst() {
        if (actId != null){
            isProfilePic = false;
            acctLst = [SELECT Age__c,DND__c,DOB__c,Name,Physician__c,Gender__c,Eligible__c,End_Date__c,Start_Date__c,Helath_Plan__c,
                        Helath_Plan_Id__c,Type,Disease__c,Id,profilePic__c FROM Account WHERE Id =: actId];
            if(acctLst[0].profilePic__c != null){
                isProfilePic = true;
            }
            claimlist = [SELECT Claim_Name__c,Claim_Status__c,Cost_of_Claim__c FROM Claim__c WHERE Id =: actId];
            caselist = [SELECT Intervention__c,Outcome__c,Reason,Status FROM Case WHERE Id =: actId];
            sleeplist = [SELECT Account__c,Awakenings__c,Date__c,Light_Sleep__c,Name,Quality__c,Title__c FROM Sleep__c  WHERE Id =: actId];
            
            if (acctLst[0].DOB__c != null && acctLst[0].Start_Date__c!= null && acctLst[0].End_Date__c!= null){
                dateFormat(acctLst);
                }
            }
      }
    
    public viewMemberCtrl(){
        actId = apexpages.currentpage().getparameters().get('Id');
        System.debug('actId========>'+actId);
        acctLst =  new List<Account>();
        claimlist = new List<Claim__c>();
        caselist = new List<Case>();
        sleeplist = new List<Sleep__c>();
        cntLst = new List<Contact>();
        addAccountPill = new Account();
        isContactBillingAddr = false;
       
    }
    

    public PageReference createGoal() {
        PageReference pf = new PageReference('/a0M/e?retURL=%2Fa0M%2Fo?core.apexpages.devmode.url=1');
        pf.getParameters().put('nooverride', '1');
        pf.setRedirect(true);
        
        return pf;
    }


    //public String Goal { get; set; }
    public List<Goal__c> goalLst {get;set;}
    public List<Goal__c> goalCloseLst {get;set;}
   // public Integer i {get;set;}
 
    
    public void getMemberGoal() {
      if(acctLst != null && acctLst.size()>0 && acctLst[0].Id != null){
            goalLst = new List<Goal__c>([SELECT Goal_Name__c,Goal_Status__c,Goal__c,Id,Intervention__c,Name,Outcome_Status2__c FROM Goal__c WHERE Goal__c =: acctLst[0].Id AND Goal_Status__c='Open']);
            goalCloseLst = new List<Goal__c>([SELECT Goal_Name__c,Goal_Status__c,Goal__c,Id,Intervention__c,Name,Outcome_Status2__c FROM Goal__c WHERE Goal__c =: acctLst[0].Id AND Goal_Status__c='Closed']);
        }
    }
    
    public void getContactBillingDetails(){
       //isContactBillingAddr = false;

        if(acctLst != null && acctLst.size()>0 && acctLst[0].Id != null){
               System.debug('acctLst[0].Id========>'+acctLst[0].Id);
            cntLst =new List<Contact>([SELECT AccountId,MailingAddress,MailingCity,MailingCountry,MailingPostalCode,MailingState,
                                        MailingStreet,MobilePhone,Name,Email,Phone FROM Contact WHERE AccountId =: acctLst[0].Id]);
             System.debug('cntLst === check=====>'+cntLst );
            if(cntLst != Null && cntLst .size() > 0 && cntLst [0].MailingStreet != null)
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
    
    
}