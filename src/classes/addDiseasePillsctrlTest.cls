@isTest
public  class addDiseasePillsctrlTest{  
 
    //public static  void testdata(){
   // addDiseasePillsctrl ctrl=new addDiseasePillsctrl();
    //}
    
  static testmethod void addAccountPilltest(){
  
   Account testAccount = new Account(Name='Test Account',DOB__c= Date.Today(),
                                  Age__c=34,DND__c=true,Physician__c='SSSSSSSSS',Gender__c='Male',Eligible__c='Yes',Helath_Plan__c='FlexiSuper',
                                  Helath_Plan_Id__c='ID0123453',Type='',Disease__c='Diabetic');
   Account testAccount1 = new Account(Name='Test Account1',DOB__c= Date.Today(),
                                  Age__c=32,DND__c=true,Physician__c='SSSSSSSSS',Gender__c='Male',Eligible__c='Yes',Helath_Plan__c='FlexiSuper',
                                  Helath_Plan_Id__c='ID40123453',Type='',Disease__c='Diabetic');
     List<Account> testacclst = new list<Account>();
       testacclst.add(testAccount);
        testacclst.add(testAccount1);
        insert  testacclst;
                                       
   testAccount = [SELECT Disease__c FROM Account WHERE Id =:testacclst[0].Id ];
    system.assertequals(testAccount.Name, 'Test Account');
     
      PageReference pageRef = Page.addDiseasePills;
      system.Test.setCurrentPage(pageRef);
     ApexPages.currentPage().getParameters().put('Id',testAccount.id);
     String id = ApexPages.currentPage().getParameters().get('id');
     system.debug('testacclst1============>'+testacclst[0].id);
     ApexPages.StandardController sc = new ApexPages.StandardController(testAccount);
       addDiseasePillsctrl cntrl = new addDiseasePillsctrl(sc);
      cntrl.savePill();
       }      
  }