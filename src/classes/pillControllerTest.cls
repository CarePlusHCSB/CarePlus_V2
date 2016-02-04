@isTest 
public class pillControllerTest{


         static testMethod void addPillsTest(){
         
         Account mbr = new Account(Name='Test Account',Disease__C='Diabetic;Prone to Stress',DOB__c= Date.Today(),Start_Date__c= Date.Today(),End_Date__c=Date.Today());
         insert mbr;
         system.assertequals(mbr.Name, 'Test Account');
         
         ApexPages.standardController sc = new ApexPages.standardController(mbr);
         pillController pc = new pillController(sc);
         pc.selectedPill = 'Diabetic';
         pc.removePills();
         
         Account mbr1 = new Account(Name='Test Account1',DOB__c= Date.Today(),Start_Date__c= Date.Today(),End_Date__c=Date.Today());
         insert mbr1;
         system.assertequals(mbr1.Name, 'Test Account1');
         
         ApexPages.standardController sc1 = new ApexPages.standardController(mbr1);
         pillController pc1 = new pillController(sc1);
         
         }

                

}