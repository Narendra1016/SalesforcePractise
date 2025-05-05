public  class LeadTriggerHandler {

    public static void updateLeadStatus(List<Lead> newRecords)
    {
        for(Lead newRecord:newRecords)
        {
            newRecord.Status = 'Working - Contacted';
            if(newRecord.Industry == 'Healthcare')
            {
                newRecord.LeadSource = 'Purchased List';
                newRecord.SICCode__c = '1616';
                newRecord.Primary__c = 'Yes';
            }
        }
       
    } 
   
}