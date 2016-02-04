@isTest
public class HompageCtrlTest {
    
     static testMethod void testHomepage()
     {
         
        Profile pfl = [select id from profile where name='Standard User'];
         
        User testUser = new User(alias = 'db', email='deepabalib@mfs.com',
        emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
        localesidkey='en_US', profileid = pfl.id,  country='United States',
        CommunityNickname = 'u1',timezonesidkey='America/Los_Angeles',
        username='deepabali@mindfiresolutions.com');
        insert  testUser;

         
        Account testAccount = new Account(Name='Test Account',DOB__c= Date.Today(),Start_Date__c= Date.Today(),End_Date__c=Date.Today(),
                                  Age__c=34,DND__c=true,Physician__c='SSSSSSSSS',Gender__c='Male',Eligible__c='Yes',Helath_Plan__c='FlexiSuper',
                                  Helath_Plan_Id__c='ID0123453'); 
        insert testAccount;
         
       case  testcase =new case(subject ='Test', AccountId=testAccount.id);
       insert testcase;
       
       
             
     PageReference pageRef = Page.CareplusConsole_Homepage_1;
     System.Test.setCurrentPage(pageRef);   
     ApexPages.StandardController sc = new ApexPages.StandardController(testuser);
     apexpages.currentPage().getparameters().put('id',testuser.id);
     HompageCtrl hcntrl = new HompageCtrl(sc);
     hcntrl.getCaseDetails();
                   
     }

}