public with sharing class extensionEx{

    Task task = new Task();
    
    public extensionEx(ApexPages.StandardController controller) {
      this.task = (Task)controller.getRecord();
      string strWhatId = ApexPages.currentPage().getParameters().get('oppIdd');
      string strOwnerId = ApexPages.currentPage().getParameters().get('ownerId');
      Task.WhatId = strWhatId ;
      Task.OwnerId = strOwnerId ;
        
    }

}