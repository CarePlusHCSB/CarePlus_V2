public class myMembersCtrl{
    
     public List<Account> memberslist{get;set;}
     public user  currentuser;
   
   
     public myMembersCtrl(){
     
     currentuser = [Select Id,FirstName,LastName from User where Id=:userinfo.getuserId()];
     if (currentuser.Id != null)
     memberslist = [SELECT Age__c,DND__c,DOB__c,Name,Physician__c,Gender__c,Eligible__c,End_Date__c,Start_Date__c,Helath_Plan__c,
                        Helath_Plan_Id__c,Type,Disease__c,Id,profilePic__c FROM Account WHERE Owner.Id =: currentuser.Id Limit 2];
     else
     memberslist = new List<Account>(); 
     
     
     }
     
     public void viewAllMembers(){
     
     memberslist = [SELECT Age__c,DND__c,DOB__c,Name,Physician__c,Gender__c,Eligible__c,End_Date__c,Start_Date__c,Helath_Plan__c,
                        Helath_Plan_Id__c,Type,Disease__c,Id,profilePic__c FROM Account WHERE Owner.Id =: currentuser.Id];
     
     }
 
 }