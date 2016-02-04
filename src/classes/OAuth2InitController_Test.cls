@isTest
public class OAuth2InitController_Test{
 @isTest
    private static void testClass()
    {
    OAuth2InitController controller = new OAuth2InitController() ;
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
    }
    private static testMethod void test() {
    test.startTest();
    PageReference pageRef = Page.OAuth2Init;
      test.stopTest();
      }
    

 static testMethod void test1()
 {   
     
            
     ApexPages.currentPage().getParameters().put('code','Je5CDuGC9OTLX2p3IieHJwUkMMynGT5ZTTvjwLwu2RQB98bS-y-yknypCzjYtLaI4675e9PR2JnD6u6cbRLabwJcUBjI6eiUmwPsZau6mE4qFHUbrwIyuWo0Z2LBaFf926_9J8ClH736u1YGuXQ4XceDY4OWDd9MKtAAbfnxlzmm5IDcr_zCnrHSDeA9z9-Ud6mhmB-veloosYWryCIXKZ56aR2Glzx7');
     OAuth2InitController cntrl = new OAuth2InitController();
     
     
     cntrl.init();
     cntrl.doAuth();
     
     /*  Test.setMock(HttpCalloutMock.class, new TestOAuth2InitController());

     HttpResponse res = cntrl.init();
     
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"foo":"bar"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());*/
     
}   
}