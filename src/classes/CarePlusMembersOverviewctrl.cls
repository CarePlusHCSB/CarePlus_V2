public class CarePlusMembersOverviewctrl{

 
    public string actId {get;set;}
    public Account acctLst {get;set;}
    
    public CarePlusMembersOverviewctrl(){
        actId = apexpages.currentpage().getparameters().get('Id');
        acctLst = [SELECT Age__c,DND__c,DOB__c,Level__c,Name,Physician__c,Gender__c,Type,Disease__c,Id FROM Account WHERE Id =: actId limit 1];
        System.debug('actId========>'+actId);
        
    }
    
}