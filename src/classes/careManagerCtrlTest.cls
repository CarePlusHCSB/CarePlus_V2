@isTest
public class careManagerCtrlTest {
    public string currentusername;
     public List<string> cmmangerlist;
     public List<string> currentuserlist;
     public List<string> cmsupervisorlist;
     public List<string> cmassociatelist;
     public Map<id,string> cmSupervisorUser;
     public Map<string,List<string>> supervisorToAssociate;
     public user currentuser;
    
    static testMethod void testcareMangerLst()
    {
     /*UserRole testUserRole = new UserRole(id='00E55000000Hqx1');
     UserRole testUserRole1 = new UserRole(id='00E55000000Hqx6');
     UserRole testUserRole2 = new UserRole(id='00E55000000HqxB');
     List<UserRole> testurolelist = new List<UserRole>();
     testurolelist.add(testUserRole);
     testurolelist.add(testUserRole1);
     testurolelist.add(testUserRole2);
     insert testurolelist;*/
     
        careManagerCtrl cmt = new careManagerCtrl();
        System.assertNotEquals(cmt, NULL);
        cmt.GetAllUsers7AboveUserRole();
             
    }

}