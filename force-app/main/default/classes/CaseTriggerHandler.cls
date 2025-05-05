public  class CaseTriggerHandler {
   public static void updateCase(List <Case> newRecords)
   {
    for(case newRecord: newRecords)
    {
        if(newRecord.Origin == 'Phone')
        {
            newRecord.Priority = 'High';
        }
        else {
            newRecord.Priority = 'Medium';
        }
    }
   }
}