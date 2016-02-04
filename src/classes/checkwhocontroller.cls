public class checkwhocontroller {

    public Task[] getMywho() {
    task[] mytask = new task[]{};
    mytask=[SELECT Id,ActivityDate,Status,Subject,Who.Name,What.Name FROM Task where OwnerId=:userinfo.getuserId() and status != 'completed'];

        return mytask;
    }

}