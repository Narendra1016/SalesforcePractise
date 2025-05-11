public  class ContactTriggerHandler {
    /**
     * author : Narendra Sontakke
     * Description : contact Trigger
     */
    // do not create contact if have no parent
    public static void showError(List<Contact> newRecords)
    {
        try {
            {
                for(Contact con :newRecords)
                {
                    if(con.AccountId == null)
                    {
                        con.addError('contact can not create without Account');
                    }

                }
            }
        } catch (Exception e) {

            system.debug(e.getMessage());
        }
    }
   
}