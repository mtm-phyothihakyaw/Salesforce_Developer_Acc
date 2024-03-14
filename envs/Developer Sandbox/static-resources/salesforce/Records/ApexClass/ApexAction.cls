public class ApexAction {
	@InvocableMethod
    public static List<Date> Logging(List<Date> inputDate) {
        System.debug('Input Date : '+ inputDate);
        return inputDate;
    }
}