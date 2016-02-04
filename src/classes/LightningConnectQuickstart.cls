public with sharing class LightningConnectQuickstart {
    List<Account> l {get;set;}
    public Boolean getCustomerIDsSet(){
       l = [SELECT Id FROM Account WHERE Customer_Id__c = null];
        
        return (l.size() == 0);
    }
    
    public void setCustomerIDs(){
        for (Integer i = 0; i < l.size(); i++) {
            l[i].Customer_Id__c = String.valueOf(i + 1);
        }
        update l;
    }
}