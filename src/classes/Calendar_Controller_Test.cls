@isTest
public class Calendar_Controller_Test {
    
    
    static testMethod void testcalendarctrl()
    {
        Event testEvent =new Event(Subject='Test Subject',isAllDayEvent=false,StartDateTime = datetime.newInstance(2016, 1, 23, 2, 30, 0),EndDateTime=datetime.newInstance(2016, 1, 23, 3, 30, 0));
        insert testEvent;
        Calendar_Controller cc= new Calendar_Controller();
        System.assertNotEquals(cc, NULL);
        cc.pageLoad();
        Calendar_Controller.calEvent ce = new Calendar_Controller.calEvent();
        
    }

}