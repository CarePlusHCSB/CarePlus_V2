public with sharing class pillcaseController {

public Case mbr{get;set;}
public set<String> pillData{get;set;}
public string memberID{get;set;}
public string selectedPill{get;set;}
public boolean showPills{get;set;}

    
    public pillcaseController(ApexPages.standardController sc){
        mbr = new Case();
        pillData = new set<String>();
                
        Case acc = (Case)sc.getRecord();
        memberID = acc.Id;
        
        //acctId = sc.getId();        
        //memberID = ApexPages.currentPage().getParameters().get('Id');
        
        if (memberID != null)
        mbr = [select Account.Disease__C,Account.profilePic__c from Case where id =: memberID Limit 1];
        
                
        if (mbr.Account.Disease__C  != null){
        string[] tmp= mbr.Account.Disease__C.split(';'); 
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
    mbr.Account.Disease__C = '';
        for (string tmp : pillData)
            mbr.Account.Disease__C += tmp + ';'; 
            
    update mbr;
     
     /*pageReference pgRef = new pageReference('apex/ViewDiseasePills?Id=00155000005oKId');
     pgRef.setRedirect(true);
     return pgRef;*/
     return null;
        
     }
     
          
}