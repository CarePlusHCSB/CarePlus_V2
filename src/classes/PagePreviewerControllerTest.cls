@isTest 
public class PagePreviewerControllerTest{

    static List<Account> testAcclist = new List<Account>();
    Id IDofthedocument;
    static Boolean showTif;
       
    static testMethod void pagepreviewTest(){
     Account testAccount =new Account(name='Test Account',Auth_Category__c='ME',Auth_Type__c ='Test Type',Service_From_Date__c =Date.Today(),
     Primary_Diag_Code__c ='test',CPT_Code__c='Test1',Total_Units__c='Two',DOB__c= Date.Today(),Start_Date__c= Date.Today(),End_Date__c=Date.Today());
     insert testAccount; 
     system.assertequals(testAccount.Name, 'Test Account');
        
    Case umCases = new Case(Description='Testing Purpose1',AccountId=testAccount.id,Type='email1',type_of_case__c='CM',Status='new',Priority='low',Subject='test1');
    insert umcases;  
    system.assertequals(umcases.Subject, 'test1');  
    PageReference pageRef = Page.PreviewPage;
    System.Test.setCurrentPage(pageRef);   
     
    apexpages.currentPage().getparameters().put('id',umcases.id);
    ApexPages.StandardController sc = new ApexPages.StandardController(umCases);
    PagePreviewerController pcntrl = new PagePreviewerController(sc);
    showTif=false; 
    
        
     Prior_Authorization__c testpa = new Prior_Authorization__c(name ='test prior',Prior_Auth__c =testAccount.id,Date_of_Approval__c =Date.Today(),Decision__c='Approved',Prior_Auth_Desc__c ='Ok'); 
     insert testpa;
      Prior_Authorization__c testpa1= [Select id,name,Prior_Auth__c,Date_of_Approval__c,Decision__c,Prior_Auth_Desc__c,Prior_Auth_Ref__c
      From Prior_Authorization__c where Prior_Auth__c =:testAccount.id];
      system.assertequals(testpa1.name, 'test prior');  
      
      pcntrl.loadTif();
        pcntrl.SaveValues();
          }

}