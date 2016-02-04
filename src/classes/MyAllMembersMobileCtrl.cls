public with sharing class MyAllMembersMobileCtrl {
public List<Account> memberslist{get;set;}

    @AuraEnabled
	public static List<Account> getMembers(){

	user  currentuser;
	currentuser = [Select Id,FirstName,LastName from User where Id=:userinfo.getuserId()];

	return [SELECT Id, Name, profilePic__c,age__c FROM Account WHERE Owner.Id =: currentuser.Id];
	}
    
}