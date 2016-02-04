@isTest
public class myMembersCtrl1test {
 
    static testMethod void testmembersctrl()
    {
        Account testAccount = new Account(Name='Test Account',DOB__c= Date.Today(),Start_Date__c= Date.Today(),End_Date__c=Date.Today(),
                                  Age__c=34,DND__c=true,Physician__c='SSSSSSSSS',Gender__c='Male',Eligible__c='Yes',Helath_Plan__c='FlexiSuper',
                                  Helath_Plan_Id__c='ID0123453'); 
        insert testAccount;
        myMembersCtrl1 mc = new myMembersCtrl1();
        mc.getviewAllMembers2();
        mc.getviewAllMembers4();
        mc.getviewAllMembers();
    }

}