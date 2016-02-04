public class QueueAssignmentctrl {
    public string caseId{get;set;}
    public String status{get;set;}

    public QueueAssignmentctrl(ApexPages.StandardController controller) {
        caseId = (Id)controller.getId();
    }
    public pagereference assignQueue(){
        Map<String,Id> queueMap = new Map<String,Id>();
        for(Group grpObj:[select id,name from Group where type='Queue']){
            queueMap.put(grpObj.Name,grpObj.id);
        
        }
        if(caseId!=null){
               if(status=='Incomplete Med Info'){
                   Case caseObj = new Case(id=caseId,ownerId=queueMap.get('Nurse Inbox'));
                   update caseObj;
               }
               else if(status=='Nurse'){
                    Case caseObj = new Case(id=caseId,ownerId=queueMap.get('Nurse Inbox'));
                   update caseObj;
               }
               else if(status=='Medical Director'){
                   Case caseObj = new Case(id=caseId,ownerId=queueMap.get('Imaging Queue'));
                   update caseObj;
               }
               else if(status=='Denial Coordinator'){
                   Case caseObj = new Case(id=caseId,ownerId=queueMap.get('Coordinator Inbox'));
                   update caseObj;
               }
              
              
        
        }
        return null;
    }

}