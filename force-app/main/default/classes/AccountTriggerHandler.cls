/**
 * Author: Narendra Sontakke
 * Description: Account Trigger
 * Date: 15-May-2025
 */
public class AccountTriggerHandler {


    // update Rating

    public static void updateRating(List<Account> newRecords)
    {
   
        for(Account acc:newRecords)
        {
            if(acc.Industry != null && acc.Industry=='Media')
            {
                acc.Rating = 'Hot';
            }
            else if(acc.Copy_Billing_To_shipping__c)
            {
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingCountry = acc.BillingCountry;
                acc.ShippingState = acc.BillingState;
            }

        }
    }

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

     
     public static void createContats(List<Account> newRecords)
     {
        List<Contact> conList = new List<Contact>();
        try{
            for(Account newRecord : newRecords)
            {
                system.debug(newRecord);
               if(newRecord.No_of_Contact__c !=null )
               {
                  for(Integer i=1 ; i<= newRecord.No_of_Contact__c; i++)
                  {
                    Contact con = new Contact();
                    con.LastName = newRecord.Name;
                    con.AccountId = newRecord.Id;
                    conList.add(con);
                  }
               }
            }

            if(!conList.isEmpty())
            {
                insert conList;
            }
        }
        catch(exception e)
        {
            system.debug(e.getMessage());
        }
     }
}
