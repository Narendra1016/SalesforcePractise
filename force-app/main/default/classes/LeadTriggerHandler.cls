public  class LeadTriggerHandler {

    public static void updateLeadStatus(List<Lead> newRecords)
    {
            try
            {
                for(Lead newRecord:newRecords)
                {
                    
                    if(newRecord.Industry == 'Healthcare')
                    {
                        newRecord.LeadSource = 'Purchased List';
                        newRecord.SICCode__c = '1616';
                        newRecord.Primary__c = 'Yes';
                    }
                }
            }
            catch(exception e)
            {
                system.debug(e.getMessage());
            }
       
 } 

    public static void createTask(List<Lead> newRecords)
    {
        try
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
        catch (Exception e)
        {
            system.debug('Error in reate task'+e.getMessage());
        }
        
    }
    
   
}