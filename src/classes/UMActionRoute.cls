public class UMActionRoute {
String country = null;
public PageReference test() {
return null;
}
public List<SelectOption> getItems() {
List<SelectOption> options = new List<SelectOption>();
options.add(new SelectOption('Approve','Approve'));
options.add(new SelectOption('Approve - Dont Send Fax','Approve - Dont Send Fax'));
options.add(new SelectOption('No Prior Auth','No Prior Auth')); 
options.add(new SelectOption('Incomplete SRF','Incomplete SRF'));
options.add(new SelectOption('You have selected Deny', 'Deny'));
options.add(new SelectOption('Request Additional Info','Request Additional Info'));
return options;
}
public String getCountry() {
return country;
}
public void setCountry(String country) { this.country = country; }
}