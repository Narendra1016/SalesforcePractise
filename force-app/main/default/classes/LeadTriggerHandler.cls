public  class LeadTriggerHandler {

    public static void updateLeadStatus(List<Lead> newRecords)
    {
        for(Lead newRecord:newRecords)
        {
            newRecord.Status = 'Working - Contacted';
        }
       
    } 
   
}