public with sharing class ViewCaseMemberCtrl {

    public ViewCaseMemberCtrl(ApexPages.StandardController controller) {
        
         caseId = apexpages.currentpage().getparameters().get('Id');
       }

          
    Id caseId {get;set;}
    public List<Case> caselist {get;set;}
    public List<Contact> cntLst {get;set;}
       
     public void getCasecntLst() {
     // cntLst = new List<Contact>([SELECT AccountId,MailingAddress,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet,MobilePhone,Name,Email,Phone FROM Contact WHERE Id = :actId]);
        /*acctLst = [SELECT Age__c,DND__c,DOB__c,Name,Physician__c,Gender__c,Eligible__c,End_Date__c,Start_Date__c,Helath_Plan__c,Helath_Plan_Id__c,Type,Disease__c,Id,profilePic__c FROM Account WHERE Id =: actId];
        claimlist = [SELECT Claim_Name__c,Claim_Status__c,Cost_of_Claim__c FROM Claim__c WHERE Id =:caseId];
        caselist = [SELECT Intervention__c,Outcome__c,Reason,Status FROM Case WHERE Id =: caseId];
        sleeplist = [SELECT Account__c,Awakenings__c,Date__c,Light_Sleep__c,Name,Quality__c,Title__c FROM Sleep__c  WHERE Id =: actId];
        dateFormat(acctLst);*/
      }
    
    public ViewCaseMemberCtrl(){
        caseId= apexpages.currentpage().getparameters().get('Id');
        System.debug('caseId========>'+caseId);
       
    }
    

    public PageReference createGoal() {
        PageReference pf = new PageReference('/a0M/e?retURL=%2Fa0M%2Fo?core.apexpages.devmode.url=1');
        pf.getParameters().put('nooverride', '1');
        pf.setRedirect(true);
        
        return pf;
    }


       
    public void getContactBillingDetails(){
     
          cntLst = new List<Contact>([SELECT AccountId,MailingAddress,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet,MobilePhone,Name,Email,Phone FROM Contact WHERE Id = :caseId ]);
    }
    
    
}