public with sharing class HompageCtrl{

    public String getMydetails() {
        return null;
    }


    public HompageCtrl() {

    }



        // Id actId {get;set;}
        Id userid{get;set;}
        public string currentusername{get;set;}
        public string currentprofilepic{get;set;}
        public string currentuserrole{get;set;}
        public string currentuserid {get;set;}
        public user  currentuser;
        public List<Case> caselist {get;set;}
        
        /*(private integer totalRecs = 0;
        private integer OffsetSize = 0;
        private integer LimitSize= 5;*/
       
        public HompageCtrl(ApexPages.StandardController controller) {
        caselist = new List<Case>();
        currentuser = new user();
        currentuser=[Select id,profilePic__c,FirstName,LastName,UserRole.Name from User where Id=:userinfo.getuserId()];
        currentuserid =currentuser.id;
        currentusername =(currentuser.FirstName+ ' '+ currentuser.LastName);
        currentprofilepic =currentuser.profilePic__c;
        currentuserrole=currentuser.UserRole.Name;
       // totalRecs = [SELECT count() FROM Case where Primary_Owner__c=:userinfo.getuserId()];
        //System.debug('Get case Details===============>'+totalRecs); 
            }
    
        public List<Case> getCaseDetails(){
    
        userid=UserInfo.getUserId();
        caselist =new List<case>([SELECT id,CaseNumber,subject,ragstatus__c,Time_Remaining__c,Primary_Owner__c FROM Case where Primary_Owner__c=:userid ORDER BY Time_Remaining__c DESC LIMIT 5]);
        //List<case> caselist = Database.Query('SELECT id,CaseNumber,subject,Time_Remaining__c,Primary_Owner__c FROM Case where Primary_Owner__c=:userid ORDER BY Time_Remaining__c DESC LIMIT :LimitSize OFFSET :OffsetSize');
        System.debug('Get case Details===============>'+caselist); 
        //caselist.setPageSize(5);
        return caselist;
        } 
        
           }