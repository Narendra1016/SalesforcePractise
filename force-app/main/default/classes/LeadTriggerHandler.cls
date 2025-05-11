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

    public static void createTask(List<Lead> newRecords)
    {
        List<Task> taskList = new List<Task>();
        for(Lead newRecord:newRecords)
        {
            Task ts = new Task();
            ts.Subject = 'Follow up';
            ts.OwnerId = newRecord.OwnerId;
            ts.Priority = 'High';
            ts.WhoId = newRecord.Id;
            taskList.add(ts);
        }
        if(!taskList.isEmpty())
        {
            insert taskList;
        }
    }
    
   
}