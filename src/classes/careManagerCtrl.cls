public with sharing class careManagerCtrl{
    
     public string currentusername{get;set;}
     public List<string> cmmangerlist{get;set;}
     public List<string> cmsupervisorlist{get;set;}
     public List<string> cmassociatelist{get;set;}
     public Map<id,string> cmSupervisorUser {get;set;}
     public Map<string,List<string>> supervisorToAssociate{get;set;}
     public user  currentuser;
     public Boolean isTree {get;set;}
     public Boolean isidList{get;set;}
     public Boolean iscmmanger{get;set;}
     public Boolean iscmsupervisor{get;set;}
     public Boolean iscmassociate{get;set;}
   
 public careManagerCtrl(){
     
     cmmangerlist= new List<string>();
     cmsupervisorlist= new List<string>();
     cmassociatelist = new List<string>();
     cmSupervisorUser = new Map<id,string>();
     currentuser = new user();
     supervisorToAssociate = new Map<string,List<string>>();
     GetAllUsers7AboveUserRole();
     
 }
 
 
  public void GetAllUsers7AboveUserRole(){
    
      currentuser=[Select id,FirstName,LastName from User where Id=:userinfo.getuserId()];
      currentusername =(currentuser.FirstName+ ' '+ currentuser.LastName);
      System.debug( 'FullName is:'+currentusername);
         
      Map<String,Id> roleMap= new Map<String,Id>();
      List<UserRole> idList =[SELECT Id,Name FROM UserRole where Name in('CM Manager','CM Supervisor','Care Management Associate')];

      isidList=false;
      if(idList!= null)
      {
          List<User> usrList=[select id,FirstName,LastName,UserRoleId  from User where UserRoleId In :idList];
          for(UserRole  ur:idList )
          {
          roleMap.put(ur.Name,ur.id);
          }
         isidList=true;
      
          if(usrList != null){
              isTree = false;
               for(User r:usrList){
               
                if(r.UserRoleId==roleMap.get('CM Manager')){
                    if(r.UserRoleId!= null){
                       cmmangerlist.add(r.FirstName+ ' '+ r.LastName);
                       isTree = true;
                       //iscmmanger=true;
                      // iscmsupervisor=false;
                       //iscmassociate=false;
                     }
                 }
                      
                 else if(r.UserRoleId==roleMap.get('CM Supervisor')){
                     if(r.UserRoleId!= null){
                           cmsupervisorlist.add(r.FirstName+ ' '+ r.LastName);
                           cmSupervisorUser.put(r.id,r.FirstName+ ' '+ r.LastName);
                           isTree = true;
                         //  iscmmanger=false;
                           //iscmsupervisor=true;
                          // iscmassociate=false;
                       }
                 }
                  else if(r.UserRoleId==roleMap.get('Care Management Associate')){
                        
                  if(r.UserRoleId!= null){
                      cmassociatelist.add(r.FirstName+ ' '+ r.LastName);
                       isTree = true;
                       //iscmmanger=false;
                       //iscmsupervisor=false;
                       //iscmassociate=true;
                  }
              }  
           }
        }
     }
     if(cmSupervisorUser.keyset()!=null){
          
     for(Id mgrUsr : cmSupervisorUser.keyset())
     {    
         List<user> tmpUsr = [select FirstName,LastName  from User where ManagerId =: mgrUsr];
         List<string> str = new List<string>();
         
         for (user u : tmpUsr)     
            str.add(u.FirstName);       
         
         supervisorToAssociate.put(cmSupervisorUser.get(mgrUsr),str);
         }
         
     }
   }
          
}