public  class TaskTriggerHandler {

    public static void updatePriority(List<Task> newRecords)
    {
        for(Task newRecord:newRecords)
        {
            newRecord.priority = 'High';
        }
    }
   
}