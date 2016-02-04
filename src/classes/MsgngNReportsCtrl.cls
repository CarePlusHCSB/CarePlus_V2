public class MsgngNReportsCtrl{
public List<Endorsement__c> endorsement{set;get;}

        public MsgngNReportsCtrl(){
        
        endorsement = [select id, Name,Location__c,Status__c,Date__c from Endorsement__c where Status__c =: 'Active'];
        
        }

}