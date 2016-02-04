public with sharing class pillController {

public Account mbr{get;set;}
public set<String> pillData{get;set;}
public string memberID{get;set;}
public string selectedPill{get;set;}
public boolean showPills{get;set;}

    
    public pillController(ApexPages.standardController sc){
        mbr = new Account();
        pillData = new set<String>();
                
        Account acc = (Account)sc.getRecord();
        memberID = acc.Id;
        
        //acctId = sc.getId();        
        //memberID = ApexPages.currentPage().getParameters().get('Id');
        
        if (memberID != null)
        mbr = [select Disease__C,profilePic__c from Account where id =: memberID Limit 1];
        
                
        if (mbr.Disease__C  != null){
        string[] tmp= mbr.Disease__C.split(';'); 
        for (String s : tmp)
        pillData.add(s);
        showPills = true;
        }
        else
        {
        showPills = false;
        }
        
    }
    
    public pageReference removePills(){
    
    //selectedPill = ApexPages.currentPage().getParameters().get('deletePill');

    pillData.remove(selectedPill);
    mbr.Disease__C = '';
        for (string tmp : pillData)
            mbr.Disease__C += tmp + ';'; 
            
    update mbr;
     
     /*pageReference pgRef = new pageReference('apex/ViewDiseasePills?Id=00155000005oKId');
     pgRef.setRedirect(true);
     return pgRef;*/
     return null;
        
     }
     
          
}