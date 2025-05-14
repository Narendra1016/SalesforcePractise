/**
 * Author: Narendra Sontakke
 * Description: Account Trigger
 * Date: 15-May-2025
 */
public class AccountTriggerHandler {

    // Do not allow user to set Ownership to 'Private' if Industry is 'Agriculture' and Type is 'Prospect'

    public static void showError(List<Account> newRecords, Map<Id, Account> oldRecords)
    {
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
     // Update all related Contacts’ Website__c field when Account Website is changed

    public static void updateContatWebsite (List<Account> newRecords,map<Id,Account> oldRecords)
    {
        map<Id,String> accountIdToWebsiteMap = new map<Id,String>();
        List<Contact> updateContat = new List<Contact>();
        try
        {
            for(Account acc:newRecords)
            {
                if(oldRecords.get(acc.id).Website != acc.Website)
                {
                    accountIdToWebsiteMap.put(acc.Id,acc.Website);
                }
            }
            if(!accountIdToWebsiteMap.isEmpty())
            {
                List<Contact> conList = [SELECT Id,AccountId, Website__c FROM Contact WHERE AccountId IN :accountIdToWebsiteMap.keyset()];

               if(!conList.isEmpty())
               {
                    for(Contact con : conList)
                    {
                        con.Website__c = accountIdToWebsiteMap.get(con.AccountId);
                        updateContat.add(con);

                    }
               }

            }
                if(!updateContat.isEmpty())
                {
                    update updateContat;
                }
        }
        catch(Exception e)
        {
            system.debug(e.getMessage());
        }
    }
     // Create the number of Contact records based on the 'Number_of_Contacts__c' field value on the Account

     
}
