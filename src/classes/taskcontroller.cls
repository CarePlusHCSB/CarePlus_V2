public class taskcontroller {

    public Task[] getMydetails() {
    task[] mytask = new task[]{};
    mytask=[SELECT Id,ActivityDate,Status,Subject,Who.Name,What.Name FROM Task where OwnerId=:userinfo.getuserId() and status != 'completed' ORDER BY ActivityDate DESC limit 5];

        return mytask;
    }

}