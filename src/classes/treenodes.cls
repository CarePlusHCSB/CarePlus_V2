public class treenodes {

/* Wrapper class to contain the nodes and their children */
public class cNodes
{

 public List<Contact> parent {get; set;}
 Public Account gparent {get;set;}

 public cNodes(Account  gp, List<Contact> p)
 {
     parent = p;
     gparent = gp;
 }
}
/* end of Wrapper class */ 

Public List<cNodes> hierarchy;

Public List<cNodes> getmainnodes()
{
    hierarchy = new List<cNodes>();
   List<Account> tempparent = [Select Id,Name,Problem__c from Account where Name ='Infosys'];
    for (Integer i =0; i< tempparent.size() ; i++)
    {
        List<Contact> tempchildren = [Select Id,FirstName,Goal__c, LastName,(Select Id,CaseNumber,Subject,Intervention__c,Outcome__c from Cases) from Contact where AccountId = :tempparent[i].Id];
        hierarchy.add(new cNodes(tempparent[i],tempchildren));
     }  
     
     
    return hierarchy;
}   
}