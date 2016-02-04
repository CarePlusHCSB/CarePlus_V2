trigger GetEmailDetails on Case (before insert) {

   
     for(Case c : Trigger.new)
     {
     String textBody = c.Description;
     System.debug('textBody ==========>'+textBody );
     System.debug('Origin ==========>'+c.Origin );
     
      if(c.Origin == 'Email' && textBody != null){
                
            String accountName;
            if(textBody.indexOf('accountName:') > -1) {
            
                Integer startPos = textBody.indexOf('accountName:');
                System.debug('startPos ==========>'+startPos );
                Integer endPos = textBody.indexOf('.',textBody.indexOf('accountName:'));
                System.debug('endPos ==========>'+endPos );
                accountName = textBody.substring(startPos+'accountName:'.length(),endPos);
            }
            System.debug('accountName==========>'+accountName);
            List<Account> actLst = [Select Id,Name from Account where Name =: accountName.trim()];
            
            System.debug('actLst==========>'+actLst);
            
             if(!actLst.isEmpty()){
                 c.AccountID = actLst[0].Id;
             }
         }
    }
}