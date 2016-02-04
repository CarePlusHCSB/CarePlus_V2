public class myMembersCtrl1{
    
     public List<Account> memberslist{get;set;}
     public List<Account> memberslist1{get;set;}
     public List<Account> memberslist2{get;set;}
     public user  currentuser;
   
   
     public myMembersCtrl1(){
     
     currentuser = [Select Id,FirstName,LastName from User where Id=:userinfo.getuserId()];
     if (currentuser.Id != null)
     memberslist = [SELECT Age__c,DND__c,DOB__c,Name,Physician__c,Gender__c,Eligible__c,End_Date__c,Start_Date__c,Helath_Plan__c,
                        Helath_Plan_Id__c,Type,Disease__c,Id,profilePic__c FROM Account WHERE Owner.Id =: currentuser.Id Limit 2];
     else
     memberslist = new List<Account>(); 
     
     
     }
     
     public list<Account> getviewAllMembers2(){
     
     memberslist = [SELECT Age__c,DND__c,DOB__c,Name,Physician__c,Gender__c,Eligible__c,End_Date__c,Start_Date__c,Helath_Plan__c,
                        Helath_Plan_Id__c,Type,Disease__c,Id,profilePic__c FROM Account WHERE Owner.Id =: currentuser.Id order by Name limit 2];
            return  memberslist;           
     
     }
     
     public list<Account> getviewAllMembers4(){
     
     memberslist1 = [SELECT Age__c,DND__c,DOB__c,Name,Physician__c,Gender__c,Eligible__c,End_Date__c,Start_Date__c,Helath_Plan__c,
                        Helath_Plan_Id__c,Type,Disease__c,Id,profilePic__c FROM Account WHERE Owner.Id =: currentuser.Id order by Name limit 2 offset 2 ];
            return  memberslist1;           
     
     }
     
       public list<Account> getviewAllMembers(){
     
     memberslist2 = [SELECT Age__c,DND__c,DOB__c,Name,Physician__c,Gender__c,Eligible__c,End_Date__c,Start_Date__c,Helath_Plan__c,
                        Helath_Plan_Id__c,Type,Disease__c,Id,profilePic__c FROM Account WHERE Owner.Id =: currentuser.Id];
            return  memberslist2;           
     
     }
 
 }