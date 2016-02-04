trigger CaseTrigger on Case (before insert, before update) 
{     
      Set<String> actNames = new Set<String>();
      Map<String,String> acctNameMap = new Map<String,String>();      
      Map<String,Id> acctIdMap = new Map<String,Id>();
      
      
      if(Trigger.isBefore && Trigger.isInsert){
      
      for(Case c : Trigger.new) {
         String textBody = c.Description;
         System.debug('textBody ==========>'+textBody );
         System.debug('Origin ==========>'+c.Origin );
            String accountName; 
            if(c.Origin == 'Email' && textBody != null){
                
                if(textBody.indexOf('accountName:') > -1) {
            
                    Integer startPos = textBody.indexOf('accountName:');
                    System.debug('startPos ==========>'+startPos );
                    Integer endPos = textBody.indexOf('.',textBody.indexOf('accountName:'));
                    System.debug('endPos ==========>'+endPos );
                    accountName = textBody.substring(startPos+'accountName:'.length(),endPos);
                    System.debug('accountName===in if loop=======>'+accountName);
                    actNames.add(accountName.trim());
                }
            }
         }
         
        System.debug('actNames values=======>'+actNames);
        List<Account> actLst = [Select Id,Name from Account where Name =:actNames];
        System.debug('actLst==========>'+actLst);
        
        for(Account ac: actLst){
        	acctNameMap.put(ac.Name,ac.Name);
        	acctIdMap.put(ac.Name,ac.Id);
        }
        system.debug('acctNameMap==========>'+acctNameMap);
        system.debug('acctIdMap==========>'+acctIdMap);
            
        for(Case c : Trigger.new)
        {	
        	 String textBody = c.Description;
	         System.debug('textBody ==========>'+textBody );
	         System.debug('Origin ==========>'+c.Origin );
	            String accountName; 
	            if(c.Origin == 'Email' && textBody != null){
	                
	                if(textBody.indexOf('accountName:') > -1) {
	            
	                    Integer startPos = textBody.indexOf('accountName:');
	                    System.debug('startPos ==========>'+startPos );
	                    Integer endPos = textBody.indexOf('.',textBody.indexOf('accountName:'));
	                    System.debug('endPos ==========>'+endPos );
	                    accountName = textBody.substring(startPos+'accountName:'.length(),endPos);
	                    System.debug('accountName=='+accountName+'<=====accountName trim=='+accountName.trim());
	                    //System.debug('=====1111=====>'+accountName == acctNameMap.get(accountName.trim()));
	                    accountName = accountName.trim();
	                    	                    
	                    if(accountName == acctNameMap.get(accountName)){
	                    	c.AccountId = acctIdMap.get(accountName);
	                    }
	                }
	            }
	        }

      }

     if(Trigger.isBefore && Trigger.isUpdate){ 
      
      List<Case> lstCs = new List<Case>();
      // Get describe fields to evaluate old and new triggers with
      Map<String, Schema.SObjectField> fldObjMap = Schema.SObjectType.Case.fields.getMap();
      List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
      // Flag to ensure only IntStatus caused this change
      Boolean hasIntStatusChanged = false;

      
      // Loop through trigger batch
      for(Case c : Trigger.new)
      {
            for(Schema.SObjectField s : fldObjMapValues){
                  String fldName = s.getDescribe().getName();
                  System.debug('fldName======>'+fldName);     
                  // Filter out fields we're not interested in
                  if(fldName == 'IntStatus__c' && fldName != 'OwnerId' && fldName != 'Status' && fldName != 'LastModifiedDate' && fldName != 'LastModifiedById' && fldName != 'SystemModstamp')
                  {
                        // Check to see if old and new are different
                        if(c.get(fldName) != Trigger.oldMap.get(c.Id).get(fldName))
                        lstCs.add(new Case(id = c.id));
                        hasIntStatusChanged = true;
                  }              
                  
            }
      }
      
      if(hasIntStatusChanged == true){  
          //invoke assignment rules only if IntStatus has changed         
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.assignmentRuleHeader.useDefaultRule = true;
        Database.update(lstCs, dmo);
      }
      
      }
}