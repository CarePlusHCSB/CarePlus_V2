@isTest
public class CaseDetailsCtrl_Test {
    
    static List<Account> testAcclist = new List<Account>();
    static Id rcdUMId = null;
    static Id rcdCMId = null;
    static Group testGroup = null;
    static Group testGroup1 = null; 
    //static String selectedValue = null;
    
    public static void testData(){
        
        DateTime d = Date.Today() ;
         
         Account testAccount = new Account(Name='Test Account',DOB__c= Date.Today(),Start_Date__c= Date.Today(),End_Date__c=Date.Today(),
                                  Age__c=34,DND__c=true,Physician__c='SSSSSSSSS',Gender__c='Male',Eligible__c='Yes',Helath_Plan__c='FlexiSuper',
                                  Helath_Plan_Id__c='ID0123453',Type='',Disease__c='Diabetic',profilePic__c='image');       
         Account testAccount2 = new Account(Name='Test Account2',DOB__c= Date.Today(),Start_Date__c= Date.Today(),End_Date__c=Date.Today());
            
         
         testAcclist.add(testAccount);
         testAcclist.add(testAccount2);
         insert testAcclist;
        
         account testAccount1 =[SELECT Name,DOB__c,Start_Date__c,End_Date__c,DND__c,Age__c,Type,Physician__c,Eligible__c,Helath_Plan__c,
                                Disease__c,profilePic__c FROM Account WHERE Id =:testAcclist[0].Id];
         system.assertequals(testAccount1.Name, 'Test Account');
       
         Goal__c testgoal = new Goal__c(Goal__c = testAcclist[0].Id,Goal_Status__c='open',
                                       Intervention__c='testing purpose1', Name='test1', Outcome__c='On Track' );
         Goal__c testgoal1 = new Goal__c(Goal__c = testAcclist[0].Id,Goal_Status__c='open',
                                        Intervention__c='testing purpose', Name='test', Outcome__c='Off Track');
         List<Goal__c> testgoallist = new List<Goal__c>();
         
         Goal__c testgoal2 = new Goal__c(Goal__c = testAcclist[0].Id, Goal_Status__c='closed',
                                        Intervention__c='testing purpose2', Name='test2', Outcome__c='Off Track');
         Goal__c testgoal3 = new Goal__c(Goal__c = testAcclist[0].Id,Goal_Status__c='closed',
                                        Intervention__c='testing purpose3', Name='test3', Outcome__c='On Track');
      
         testgoallist.add(testgoal);
         testgoallist.add(testgoal1);
         testgoallist.add(testgoal2);
         testgoallist.add(testgoal3);
         insert testgoallist;
          
         system.assertNotEquals(testgoallist[0].Id, NULL); 
          
          Goal__c testgoal5 = [SELECT Goal_Status__c,Goal__c,Id,Intervention__c,Name,Outcome_Status2__c
                               FROM Goal__c WHERE Id =:testgoallist[0].Id AND Goal_Status__c='open' 
                               AND Goal__c = :testAcclist[0].Id];
          system.assertequals(testgoal5.Name, 'test1');
        
         Claim__c testclaim = new Claim__c(Claims__c = testAcclist[0].Id,
                                           Claim_Status__c='paid',
                                           Claim_Name__c='new');
         Claim__c testclaim1 = new Claim__c(Claims__c = testAcclist[0].Id,Claim_Name__c='new1');
         List<Claim__c> testclaimlist = new List<Claim__c>();
         testclaimlist.add(testclaim);
         testclaimlist.add(testclaim1);
         insert testclaimlist;
         system.assertNotEquals(testclaimlist[0].Id, NULL); 
         
         Claim__c testclaim2= [SELECT Id,ClaimNumber__c,Claims__c,Claim_Name__c,Claim_Status__c FROM Claim__c WHERE Id=:testclaimlist[0].Id];
         system.assertNotEquals(testclaim2.id,Null);
          
          
         contact conlist = new contact(AccountId=testAcclist[0].Id, FirstName='xyzb',LastName='abc', MailingCity='hyd',MailingCountry='india',
                                        MailingPostalCode='67566',MailingState='andra',MailingStreet='pocharam');
         contact conlist1 = new contact(AccountId=testAcclist[0].Id,FirstName='xyza',LastName='abc',MailingCity='hyderabad',MailingCountry='ind',
                                        MailingPostalCode='675677',MailingState='andhra',MailingStreet='pocharam1');
         List<contact> testconlist = new List<contact>();
         testconlist.add(conlist);
         testconlist.add(conlist1);
         insert testconlist; 
         system.assertNotEquals(testconlist[0].Id, NULL);
         
         testGroup = new Group(Name='test group', Type='Queue');
         testGroup1 = new Group(Name='test group1', Type='Queue');
         
         insert testGroup;
         insert testGroup1; 
         system.assertNotEquals(testGroup.Id, NULL);  
         system.assertNotEquals(testGroup1.Id, NULL);   
         
          System.runAs(new User(Id=UserInfo.getUserId()))
          {
              QueuesObject testQueue = new QueueSObject(QueueID = testGroup.id, SObjectType = 'Case');
              insert testQueue;
              system.assertNotEquals(testQueue.Id, NULL);  
              QueuesObject testQueue1 = new QueueSObject(QueueID = testGroup1.id, SObjectType = 'Case');
              insert testQueue1;
              system.assertNotEquals(testQueue1.Id, NULL);  
          }  
               
         Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
         Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName(); 
                       
         System.debug('CaseRecordTypeInfo=============>'+CaseRecordTypeInfo);            
     
         rcdUMId = CaseRecordTypeInfo.get('Utilization Management').getRecordTypeId() ;
         rcdCMId = CaseRecordTypeInfo.get('CM_CaseManagement').getRecordTypeId() ;
         System.debug('rcdUMId=====>'+rcdUMId +'<====rcdCMId====>'+rcdCMId);
        
    }
    
    static testMethod void testUMCases(){
        
        CaseDetailsCtrl_Test.testData();
         Case umCases = new Case(AccountID  = testAcclist[0].Id, RecordTypeId = rcdUMId, ownerid = testGroup.id,
                            Description ='Testing Purpose1',Type ='email1', type_of_case__c ='CM',Status ='new',
                            Priority = 'low',Subject ='test1');
                            
        insert umCases;      
        system.assertNotEquals(umCases.Id,NULL);
                
        ApexPages.currentPage().getParameters().put('Id',umCases.id);
        ApexPages.StandardController scUMCases = new ApexPages.StandardController(umCases);
        CaseDetailsCtrl umCasecntrl = new CaseDetailsCtrl(scUMCases);
      
        umCasecntrl.getClaimDetails();
        umCasecntrl.getAcctLst();
        umCasecntrl.getMemberGoal();
        umCasecntrl.createGoal();
        umCasecntrl.getCaseType();
        umCasecntrl.getCaseEmailAttachment();
        umCasecntrl.getContactBillingDetails();
        umCasecntrl.dateFormat(testAcclist);
        umCasecntrl.assignCaseToQueue();
            
    }
    
    static testMethod void testCMCases(){
               
        CaseDetailsCtrl_Test.testData();                      
        String textDesc = 'accountName: ' + testAcclist[0].Name + '.'; 
        System.debug('textDesc=======>'+textDesc);
          
        Case caseEmail = new Case(AccountID  = testAcclist[0].Id,RecordTypeId = rcdCMId, Origin = 'Email',
                                Description = textDesc,Type='email2',
                                type_of_case__c='CM',Status='new',
                                Priority='low',Subject='test2');
          
          insert caseEmail;      
          system.assertNotEquals(caseEmail.Id,NULL);                    
     
          EmailMessage[] email = new EmailMessage[0];
           
          email.add(new EmailMessage
                       (FromAddress = 'test@abc.org', 
                        Incoming = True, 
                        ToAddress= 'sridhar.g09@1etrpj7z828k3r24h1eszc0hzdwh6p235pohxbjvv51ptwbzza.55-5avjeay.cs41.case.sandbox.salesforce.com', 
                        Subject = 'Test email', TextBody = caseEmail.Description,
                        parentId = caseEmail.Id));
          
          insert email;  
          system.assertNotEquals(email,NULL);      
         
         Blob b = Blob.valueOf('Test Data');
         Attachment attachment = new Attachment();
         attachment.ParentId = caseEmail.Id;
         attachment.Name = 'Test Attachment for Parent';
         attachment.ContentType ='test';
         attachment.Description='test purpose only';
         attachment.Body = b;
        
         Blob b1 = Blob.valueOf('Test Data2');
         Attachment attachment1 = new Attachment();
         attachment1.ParentId = caseEmail.Id;
         attachment1.Name = 'Test Attachment for Parent1';
         attachment.ContentType ='test1';
         attachment.Description='test purpose only1';
         attachment1.Body = b1;  
         
         List<Attachment> attachlst= new  List<Attachment>();
         attachlst.add(attachment);
         attachlst.add(attachment1);
         insert attachlst;
         system.assertNotEquals(attachlst,NULL);
          
         Attachment attachment2= [SELECT Body, ContentType,Description,Name,ParentId FROM Attachment WHERE Id =:attachlst[0].Id];
         system.assertequals(attachment2.Name, 'Test Attachment for Parent');
             
         ApexPages.currentPage().getParameters().put('Id',caseEmail.id);
         
         ApexPages.StandardController sc = new ApexPages.StandardController(caseEmail);
         CaseDetailsCtrl cntrl = new CaseDetailsCtrl(sc);
      
         cntrl.getClaimDetails();
         cntrl.getAcctLst();
         cntrl.getMemberGoal();
         cntrl.createGoal();
         cntrl.getCaseType();
        
         cntrl.att = attachlst[0];
         Attachment at = cntrl.att;
         System.assertEquals(at.Id,attachlst[0].Id);
         cntrl.getCaseEmailAttachment();
         
         cntrl.getContactBillingDetails();
         cntrl.dateFormat(testAcclist);
         cntrl.assignCaseToQueue();
         
         cntrl.selectedValue = 'Nurse';
         cntrl.assignCaseToQueue();
      
         cntrl.selectedValue = 'Medical Director';
         cntrl.assignCaseToQueue();
         
         cntrl.selectedValue = 'Denial Coordinator';
         cntrl.assignCaseToQueue();
                
    }

}