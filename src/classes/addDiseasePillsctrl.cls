public with sharing class addDiseasePillsctrl{

     public Account addAccountPill {get;set;}
     public Id actId {get;set;}
     public List<string> pillsSelected{get;set;}
     public List<SelectOption> pillsToBeAdded {get;set;}

    public addDiseasePillsctrl(ApexPages.StandardController sc){
        pillsSelected = new List<string>();
        pillsToBeAdded  = new List<SelectOption>();
        actId = apexpages.currentpage().getparameters().get('id');
        addAccountPill = [SELECT Disease__c FROM Account WHERE Id =: actId];
        
        if(addAccountPill.Disease__C !=null){
        
        /*pillsToBeAdded.add(new SelectOption('Diabetic','Diabetic'));
        pillsToBeAdded.add(new SelectOption('Heart Patient','Heart Patient'));
        pillsToBeAdded.add(new SelectOption('Prone to Stress','Prone to Stress'));
        pillsToBeAdded.add(new SelectOption('Alzheimer Patient','Alzheimer Patient'));
        pillsToBeAdded.add(new SelectOption('Medicare Advantage','Medicare Advantage'));*/
        
        Set<string> str = new Set<string>();
        str.add('Diabetic');
        str.add('Heart Patient');
        str.add('Prone to Stress');
        str.add('Alzheimer patient');
        str.add('Medicare Advantage');
        
        string[] tmp =  addAccountPill.Disease__C.split(';');
        str.removeAll(tmp);
        
        for(string s : str){
        pillsToBeAdded.add(new SelectOption(s,s));        
        }
        
        }
        
        else
        {Set<string> str = new Set<string>();
        str.add('Diabetic');
        str.add('Heart Patient');
        str.add('Prone to Stress');
        str.add('Alzheimer patient');
        str.add('Medicare Advantage');
        for(string s : str){
        pillsToBeAdded.add(new SelectOption(s,s));        
        }

        }
        
    }
    
    public void savePill(){
           addAccountPill = [SELECT Disease__c FROM Account WHERE Id =: actId]; 
           
           if (addAccountPill.Disease__C != null)    {
                for (string s : pillsSelected)
                addAccountPill.Disease__C += ';' + s;
                update addAccountPill;
            }
            else{
            addAccountPill.Disease__C = '';
            for (string s : pillsSelected)
                addAccountPill.Disease__C += ';' + s;
                update addAccountPill;
            }
            
    }


}