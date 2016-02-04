public class Calendar_Controller {
 
   // public Boolean includeMyEvents {get;set;}
    public list<calEvent> events {get;set;}
         
    String dtFormat = 'EEE, d MMM yyyy HH:mm:ss z';
        
  /*  public Calendar_Controller() {
      includeMyEvents = true;
    }
    */
    public PageReference pageLoad() {
    events = new list<calEvent>();
    list<Event> events1 =   [select Id, Subject, isAllDayEvent, StartDateTime, EndDateTime from Event where OwnerID = :UserInfo.getUserId()]; 
    if(events1 != null){ 
    for(Event evnt:events1 )
    {
        DateTime startDT = evnt.StartDateTime;
        DateTime endDT = evnt.EndDateTime;
        calEvent myEvent = new calEvent();
             
        myEvent.title = evnt.Subject;
        myEvent.allDay = evnt.isAllDayEvent;
        myEvent.startString = startDT.format(dtFormat);
        myEvent.endString = endDT.format(dtFormat);
        myEvent.url = '/' + evnt.Id;
        //  myEvent.className = 'event-personal';
        events.add(myEvent);
    }
     }
          
     return null;
    }
    
   /*
    public PageReference toggleMyEvents() {
        if(includeMyEvents){
            includeMyEvents = false;
        }
        else{
            includeMyEvents = true;
        }
        pageload();
        return null;
    }
 */
       @TestVisible 
        public class calEvent{
        public String title {get;set;}
        public Boolean allDay {get;set;}
        public String startString {get;set;}
        public String endString {get;set;}
        public String url {get;set;}
        public String className {get;set;}
    }
}