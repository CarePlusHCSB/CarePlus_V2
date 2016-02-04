@isTest
public class GetEmailDetails_Test {
    
    static Case emailCase;
    
    static testMethod void testGetEmailDetails(){
         
         Account testAccount = new Account(Name='Test Account',DOB__c= Date.Today(),Start_Date__c= Date.Today(),End_Date__c=Date.Today(),
                                  Age__c=34,DND__c=true,Physician__c='Sridhar',Gender__c='Male',Eligible__c='Yes',Helath_Plan__c='FlexiSuper',
                                  Helath_Plan_Id__c='ID0123453',Type='',Disease__c='Diabetic',profilePic__c='image');
         insert testAccount;
         system.assertequals(testAccount.Name, 'Test Account');
                                  
         Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
         Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
         System.debug('CaseRecordTypeInfo=============>'+CaseRecordTypeInfo);            
         Id rcdCMId = CaseRecordTypeInfo.get('CM_CaseManagement').getRecordTypeId() ;                         
                            
        String textDesc = 'accountName: ' + testAccount.Name + '.'; 
        System.debug('textDesc=======>'+textDesc);
           
        emailCase = new Case(AccountID  = testAccount.Id,RecordTypeId = rcdCMId, Origin = 'Email',Status='new',Priority='low',
                            Subject='test2',type_of_case__c='CM',Description = textDesc);
          
        insert emailCase;
         system.assertequals(emailCase.Subject, 'test2');
    }
}