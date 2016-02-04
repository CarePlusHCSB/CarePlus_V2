Public with sharing class DeferenceDemoController {
Public List<string> CusrrentUserRole{get;set;}
Public List<String> RolesInheirarchy{get;set;}
  Public DeferenceDemoController(){
     CusrrentUserRole = New List<string>();
     CusrrentUserRole.add([select UserRoleid from user where id =:UserInfo.getUserId() limit 1].UserRoleId); 
     System.debug('*******'+CusrrentUserRole);
  }
  Public Void DemoMethod(){
   System.debug('*******'+CusrrentUserRole);
 
    RolesInheirarchy = New List<Id>();
    RolesInheirarchy = getAllRoleInHeirarchy(CusrrentUserRole);
  }
    
  Public List<string> getAllRoleInHeirarchy (List<Id> UserRole) {     
    List<string> currentRoleIds = new List<string>();     
    for(UserRole userRoleName :[select Id,name from UserRole where ParentRoleId  = :UserRole AND ParentRoleID != null]){    
        currentRoleIds.add(userRoleName.id);    
    }    
   if(currentRoleIds.size() > 0)      
      currentRoleIds.addAll(getAllRoleInHeirarchy(currentRoleIds));     
   List<string> RoleList = New List<string>();  
   for(UserRole r:[select name from userrole where id In:currentRoleIds])
       RoleList.add(r.name);      
   return RoleList;
  }        
}