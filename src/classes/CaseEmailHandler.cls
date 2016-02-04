global class CaseEmailHandler implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
    Messaging.InboundEnvelope envelope) {

        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        
        String textBody = email.plainTextBody;
            System.debug('textBody ==========>'+textBody );
                
            String accountName;
            if(textBody.indexOf('accountName:') > -1) {
            
                Integer startPos = textBody.indexOf('accountName:');
                System.debug('startPos ==========>'+startPos );
                Integer endPos = textBody.indexOf('.',textBody.indexOf('accountName:'));
                System.debug('endPos ==========>'+endPos );
                accountName = textBody.substring(startPos+'accountName:'.length(),endPos);
            }
        System.debug('accountName==========>'+accountName);
        Account act = [Select Id,Name from Account where Name =: accountName.trim()];
        System.debug('act==========>'+act);
        
        System.debug('email.subject=====>'+email.subject);
         case c = new case();
         
         c.subject = email.subject;
         if(act != null){
             c.AccountID = act.Id;
         }
         //insert c;
         System.debug('Case INserted====>'+c.Id);
         
        return result ;
    }  
    
  }