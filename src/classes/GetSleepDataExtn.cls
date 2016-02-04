public with sharing class GetSleepDataExtn {
    public Account acc{get;set;}
    public String response{get;set;}
    public List<Sleep__c> sleepList{get;set;}
    Long offset = 5500L * 60L * 60L;
    Date maxDate = null;
    Integer calloutCount = 0;
    
    public GetSleepDataExtn(ApexPages.StandardController controller) {
        sleepList = new List<Sleep__c>();
        acc = [Select Id,Jawbone_Access_Token__c,(Select Id,Date__c from Sleep_Data__r) FROM Account WHERE Id = :controller.getRecord().Id];
        for(Sleep__c s : acc.Sleep_Data__r){
            if(maxDate==null || s.Date__c > maxDate)
                maxDate = s.Date__c;
        }
        system.debug('maxDate--------------->'+maxDate);
        dataCallout('https://jawbone.com/nudge/api/v.1.1/users/@me/sleeps');
    }
    
    private void dataCallout(String endpoint){
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setHeader('Authorization','Bearer '+acc.Jawbone_Access_Token__c);
        req.setHeader('Accept','application/json');
        
        HttpResponse res = new Http().send(req);
        response = res.getBody();
        response = response.replace('"time"','"time2"');
        response = response.replace('"date"','"date2"');
        calloutCount++;
    }
    
    public void getData(){
        JSONParser parser = JSON.createParser(response);
        SleepDetails sd = null;
           try{
               sd = (SleepDetails)parser.readValueAs(SleepDetails.class);
           }catch(Exception e){
               system.debug('Error--'+e.getMessage());
           }
        for(Item i : sd.data.items){
            Sleep__c sl = new Sleep__c(Account__c = acc.Id);
            sl.Asleep_Time__c = i.details.asleep_time!=0?Datetime.newInstance(i.details.asleep_time*1000):null;
            sl.Awake_For__c = i.details.awake;
            sl.Awakenings__c = i.details.awakenings;
            sl.Awake_Time__c = i.details.awake_time!=0?Datetime.newInstance(i.details.awake_time*1000):null;
            sl.Duration__c = i.details.duration;
            sl.Light_Sleep__c = i.details.light;
            sl.Quality__c = i.details.quality;
            sl.Smart_Alarm_Fired__c = i.details.smart_alarm_fire!=0?Datetime.newInstance(i.details.smart_alarm_fire*1000):null;
            sl.Sound_Sleep__c = i.details.sound;
            sl.Sub_Type__c = i.sub_type;
            sl.Sunrise__c = i.details.sunrise!=null && i.details.sunrise!=0?Datetime.newInstance(i.details.sunrise*1000):null;
            sl.Sunset__c = i.details.sunset!=null && i.details.sunset!=0?Datetime.newInstance(i.details.sunset*1000):null;
            sl.Time_Completed__c = i.time_completed!=0?Datetime.newInstance(i.time_completed*1000):null;
            sl.Time_Created__c = i.time_created!=0?Datetime.newInstance(i.time_created*1000):null;
            sl.Time_Updated__c = i.time_updated!=0?Datetime.newInstance(i.time_updated*1000):null;
            sl.Timezone__c = i.details.tz;
            sl.Title__c = i.title;
            sl.Name = i.xid;
            String theDate = String.valueOf(i.date2);
            sl.Date__c = Date.parse(theDate.substring(4,6)+'/'+theDate.substring(6,8)+'/'+theDate.substring(0,4));
            //if(maxDate == null || sl.Date__c > maxDate)
                sleepList.add(sl);
        }
        
        if(sd.data.links != null && sd.data.links.next != null && Limits.getLimitCallouts() > 0){
            dataCallout('https://jawbone.com'+sd.data.links.next);
            getData();
        }
        else{
            try{
                insert sleepList;
            }catch(Exception e){
                system.debug('Error '+e.getMessage());
            }
        }
    }
    
    public class SleepDetails {

        public Meta meta{get;set;}
        public Data data{get;set;}
        
        public SleepDetails(Meta meta,Data data){
            this.meta = meta;
            this.data = data;
        }
    }
    
    public class Data {

        public List<Item> items = new List<Item>();
        public Links links{get;set;}
        public long size{get;set;}
        
        public List<Item> getItems() {
        return items;
        }
        
        public void setItems(List<Item> items) {
            this.items = items;
        }
    }
    
    public class Details {

        public long body{get;set;}
        public long sound{get;set;}
        public long smart_alarm_fire{get;set;}
        public long awakenings{get;set;}
        public long light{get;set;}
        public long mind{get;set;}
        public long asleep_time{get;set;}
        public long awake_time{get;set;}
        public long awake{get;set;}
        public long rem{get;set;}
        public long duration{get;set;}
        public String tz{get;set;}
        public long quality{get;set;}
        public long sunset{get;set;}
        public long sunrise{get;set;}
        
        public Details(long body,long sound,long smart_alarm_fire,long awakenings,long light,long mind,long asleep_time,long awake_time,long awake,long rem,long duration,String tz,long sunset,long sunrise){
            this.body = body;
            this.sound = sound;
            this.smart_alarm_fire = smart_alarm_fire;
            this.awakenings = awakenings;
            this.light = light;
            this.mind = mind;
            this.asleep_time = asleep_time;
            this.awake_time = awake_time;
            this.awake = awake;
            this.rem = rem;
            this.duration = duration;
            this.tz = tz;
            this.quality = quality;
            this.sunset = sunset;
            this.sunrise = sunrise;
        }
    }
    
    public class Item {

        public long time_completed{get;set;}
        public String xid{get;set;}
        public String title{get;set;}
        public long time_created{get;set;}
        public long time_updated{get;set;}
        public Details details{get;set;}
        public long date2{get;set;}
        public boolean shared{get;set;}
        public long sub_type{get;set;}
        public String snapshot_image{get;set;}
        public Item(long time_completed,String xid,String title,long time_created,long time_updated,Details details,long date2,boolean shared,long sub_type,String snapshot_image){
            this.time_completed = time_completed;
            this.xid = xid;
            this.title = title;
            this.time_created = time_created;
            this.time_updated = time_updated;
            this.details = details;
            this.date2 = date2;
            this.shared = shared;
            this.sub_type = sub_type;
            this.snapshot_image = snapshot_image;
        }
    }
    
    public class Links {

    public String next{get;set;}
    
    public Links(String next){
        this.next = next;
    }

    }
    
    public class Meta {

        public String user_xid{get;set;}
        public String message{get;set;}
        public long code{get;set;}
        public long time2{get;set;}
        
        public Meta(String userXid,String message,long code,long time2){
            this.user_xid = user_xid;
            this.message = message;
            this.code = code;
            this.time2 = time2;
        }
    }
}