trigger CaseTaskCreateTrigger on Case (after update) {
List<Task> tasks = new List<Task>(); 
List<Case> caseList = Trigger.new; 
for (Case cs : caseList) { 

if (cs.generateTasks__c=='YES'){
Task tsk1 = new Task(CaseId__c = cs.Id, Subject='Care Manager will facilitate self-management activities by providing coaching/support and condition specific information');
Task tsk2 = new Task(CaseId__c = cs.Id, Subject='Care Manager communicates self-management plan');
Task tsk3 = new Task(CaseId__c = cs.Id, Subject='Adherence to prescribed treatment plan');
Task tsk4 = new Task(CaseId__c = cs.Id, Subject='Attends prescribed physician visits');
Task tsk5 = new Task(CaseId__c = cs.Id, Subject='Adherence to prescribed medication regime');
tasks.add(tsk1); 
tasks.add(tsk2); 
tasks.add(tsk3); 
tasks.add(tsk4); 
tasks.add(tsk5); 
}
 //add task to record
} 
insert tasks; 
}