public class imagingQueueCase_cntrlr {
    String queid='';

    public imagingQueueCase_cntrlr(ApexPages.StandardController controller) {

    }
    public List<Case> getCases() {        
        Id profileId=userinfo.getprofileid();
        String profName=[Select Id,Name from Profile where Id=:profileId].Name;
                
        if(profName =='UM_Nurse' || profName=='CM_UM_Nurse'){
            queid=[select Id from Group where Name = 'Nurse Inbox' and Type = 'Queue'].id;        
        }
        else{
        queid=[select Id from Group where Name = 'imaging queue' and Type = 'Queue'].id;
        }
        
        system.debug('%%%%%Queue Id is'+queid);
        String query= 'select Id,caseNumber,subject,ragstatus__c,type_of_case__c FROM Case where ownerid=:queid';
        
        
        if(profName=='UM_Nurse'){
            query+=' and Type_of_Case__c=\'UM\'';
        }
        else if(profName=='CM_UM_Nurse' || profName=='UM_Co-ordinator'){
            query+=' and (Type_of_Case__c=\'UM\' or Type_of_Case__c=\'CM\')';
        }
        else if(profName=='UM_Clerk'){
            query+=' and AccountId=null';
        }
        system.debug('%%%%%Query is'+query);
        return Database.query(query);
    }

}