public with sharing class OAuth2InitController {
    private static String clientId = 'RRuh17UxhWE';
    private static String clientSecret = 'eba2bb1fab050411e704e7e735f87c92a3820b1b';
    private static String accountId = '00155000004bfHy';
    public String response{get;set;}
    
    public OAuth2InitController(){
        if(ApexPages.currentPage().getParameters().size() > 0){
           String code = ApexPages.currentPage().getParameters().get('code');
           system.debug(ApexPages.currentPage().getParameters().size());
           system.debug(code);
           if(code!=null){
               HTTPRequest req = new HttpRequest();
               req.setEndpoint('https://jawbone.com/auth/oauth2/token');
               req.setBody('client_id='+clientId+'&client_secret='+clientSecret+'&grant_type=authorization_code&code='+code);
               req.setMethod('POST');
               Http h = new Http();
               HttpResponse res = h.send(req);
               response = res.getBody();
           }
        }
    }
    
    public void init(){
        if(response != null){
           JSONParser parser = JSON.createParser(response);
           try{
               TokenDetails t = (TokenDetails)parser.readValueAs(TokenDetails.class);
               Account a = new Account(Id=AccountId, Jawbone_Access_Token__c = t.access_token, Jawbone_Refresh_Token__c = t.refresh_token);
               update a;
           }catch(Exception e){
               system.debug('Error--'+e.getMessage());
           }
       }
    }
    
    public PageReference doAuth() {
        return new PageReference('https://jawbone.com/auth/oauth2/auth?response_type=code&client_id='+clientId+'&scope=basic_read sleep_read move_read meal_Read&redirect_uri=https%3A%2F%2Fc.cs41.visual.force.com%2Fapex%2FOAuth2Init');
    }
    
    class TokenDetails{
        public String access_token;
        public String token_type;
        public Long expires_in;
        public String refresh_token;
        
        public TokenDetails(String access_token,String token_type,Long expires_in,String refresh_token){
            this.access_token = access_token;
            this.token_type = token_type;
            this.expires_in = expires_in;
            this.refresh_token = refresh_token;
        }
    }

}