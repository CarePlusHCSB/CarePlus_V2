public with sharing class caseRedirect {
    Case caseInst {get;set;}
    private ApexPages.StandardController stdController;

    //constructor
    public caseRedirect(ApexPages.StandardController stdController){
        this.stdController = stdController;
        caseInst = (Case)stdController.getRecord();
        caseInst.IntStatus__c = ApexPages.currentPage().getParameters().get('Id');
    }

    public PageReference saveAndReturn()
    {
    stdController.save();
    PageReference parentPage = new PageReference('/500');
    parentPage.setRedirect(true);
    return parentPage;
    }
}