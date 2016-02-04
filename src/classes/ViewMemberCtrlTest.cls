@isTest 
public class ViewMemberCtrlTest
{ 
    public String strDOB;
    public String strStartDate;
    public String strEndDate;
    public String Goal;
    public integer i;
    
     @isTest
    private static void testClass()
    {
    viewMemberCtrl controller = new viewMemberCtrl() ;
    }
  /*system.Test.StartTest(); 
     ApexPages.StandardController sc = new ApexPages.StandardController(testAccount);
     ViewMemberCtrl controller = new ViewMemberCtrl(sc);

     PageReference pageRef = Page.CarePlus_ViewMemberInfo_Dreamweaver; // Add your VF page Name here
     pageRef.getParameters().put('id', String.valueOf(testAccount.Id));
     Test.setCurrentPage(pageRef); 
     system.Test.StopTest();*/
         
  static testMethod void testAcctLst()
 {
     DateTime d = Date.Today() ;
     
     Account testAccount = new Account(Name='Test Account',DOB__c= Date.Today(),Start_Date__c= Date.Today(),End_Date__c=Date.Today());
       
     Account testAccount2 = new Account(Name='Test Account2',DOB__c= Date.Today(),Start_Date__c= Date.Today(),End_Date__c=Date.Today());
        
     List<Account> testAcclist = new List<Account>();
     testAcclist.add(testAccount);
     testAcclist.add(testAccount2);
     insert testAcclist;
    
     account testAccount1 =[SELECT Name FROM Account WHERE Id =:testAcclist[0].Id];
     system.assertequals(testAccount1.Name, 'Test Account');
   
     Goal__c testgoal = new Goal__c(Goal__c = testAcclist[0].Id, Name ='new member', Goal_Status__c='open');
     Goal__c testgoal1 = new Goal__c(Goal__c = testAcclist[0].Id, Name ='new member1',Goal_Status__c='open');   
     Goal__c testgoal2 = new Goal__c(Goal__c = testAcclist[0].Id, Name ='new member2', Goal_Status__c='closed');
     Goal__c testgoal3 = new Goal__c(Goal__c = testAcclist[0].Id, Name ='new member3',Goal_Status__c='closed');
     List<Goal__c> testgoallist = new List<Goal__c>();
     testgoallist.add(testgoal);
     testgoallist.add(testgoal1);
     testgoallist.add(testgoal2);
     testgoallist.add(testgoal3);   
     insert testgoallist;
        Goal__c testgoal5 = [SELECT Goal_Status__c,Goal__c,Id,Intervention__c,Name,Outcome_Status2__c
                             FROM Goal__c WHERE Id =:testgoallist[0].Id];
        system.assertNotEquals(testgoal5, NULL);    
         
     Claim__c testclaim = new Claim__c(Claims__c = testAccount.Id,Claim_Name__c='new');
     insert testclaim; 
     system.assertNotEquals(testclaim, NULL); 
     //testclaim = [SELECT Claim_Name__c FROM Claim__c WHERE Id =:testclaim.Id];
     
     Sleep__c tests = new Sleep__c(Account__c =testAccount.Id,Title__c = 'Test new');
     insert  tests;
     system.assertNotEquals(tests , NULL); 
     //tests = [SELECT Title__c FROM Sleep__c WHERE Id =:tests.Id];
     
     PageReference pageRef = Page.CarePlus_ViewMemberInfo_Dreamweaver;
      system.Test.setCurrentPage(pageRef);
     ApexPages.currentPage().getParameters().put('Id',testAccount.id);
     String id = ApexPages.currentPage().getParameters().get('id');
     system.assertEquals(true,id!=null);
     ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(testAccount);
     ViewMemberCtrl cntrl = new ViewMemberCtrl(sc);
     cntrl.getAcctLst();
     cntrl.getMemberGoal();
     cntrl.createGoal();
     cntrl.getContactBillingDetails();
     cntrl.dateFormat(testAcclist);
     
     
      

     
   
    
   

        // Case testcase = new Case(Account = testAccount.Id);
   //    insert testcase;
 }
}