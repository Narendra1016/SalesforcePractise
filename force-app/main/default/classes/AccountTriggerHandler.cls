/**
 * Author: Narendra Sontakke
 * Description: Account Trigger
 * Date: 15-May-2025
 */
public class AccountTriggerHandler {

    // Do not allow user to set Ownership to 'Private' if Industry is 'Agriculture' and Type is 'Prospect'

    public static void showError(List<Account> newRecords, Map<Id, Account> oldRecords) {
        try {
            for (Account acc : newRecords) {
                Account oldAcc = oldRecords.get(acc.Id);
                if (acc.Industry == 'Agriculture' && acc.Type == 'Prospect') {
                    if (oldAcc != null && acc.Ownership == 'Private' && oldAcc.Ownership != acc.Ownership) {
                        acc.addError('You cannot set Ownership to Private for an Agriculture Prospect Account.');
                    }
                }
            }
        } catch (Exception e) {
            System.debug('Error in AccountTriggerHandler: ' + e.getMessage());
        }
    }
}
