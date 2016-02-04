public class GoalCtrl {

    public PageReference createGoal() {
        PageReference pf = new PageReference('/a0M/e?retURL=%2Fa0M%2Fo?core.apexpages.devmode.url=1');
        pf.getParameters().put('nooverride', '1');
        pf.setRedirect(true);
        
        return pf;
    }


    public String Goal { get; set; }
    public List<Goal__c> goalLst {get;set;}
    public List<Goal__c> goalCloseLst {get;set;}
    public Integer i {get;set;}
    
    public void getMemberGoal() {
      
        goalLst = new List<Goal__c>([SELECT Goal_Name__c,Goal_Status__c,Goal__c,Id,Intervention__c,Name,Outcome_Status2__c FROM Goal__c WHERE Goal__c = '00155000005oKIdAAM' AND Goal_Status__c='Open']);
        goalCloseLst = new List<Goal__c>([SELECT Goal_Name__c,Goal_Status__c,Goal__c,Id,Intervention__c,Name,Outcome_Status2__c FROM Goal__c WHERE Goal__c = '00155000005oKIdAAM' AND Goal_Status__c='Closed']);
    }

}