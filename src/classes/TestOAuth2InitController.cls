@isTest
global class TestOAuth2InitController implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('https://jawbone.com', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"access_token", "aV1SI82xvToh0Y0QK0Vif-LxZsI_ZfMz7I4wH0VUp2JC7LrLTyKlEagu2_juwyhardG4YRHS8Up78thyDMNYJFECdgRlo_GULMgGZS0EumxrKbZFiOmnmAPChBPDZ5JP"}');
        res.setStatusCode(200);
        return res;
    }
}