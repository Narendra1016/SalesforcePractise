public with sharing class OpportunityTriggerHandler {
    public static void createTaskforPriviligedUsers(List<Opportunity> newRecords)
    {
        List<Task> taskRecord = new List<Task>();
        for(Opportunity opp:newRecords)
        {
            if(opp.StageName =='Closed Won' )
            {
                Task tsk = new Task();
                tsk.Subject = 'Web';
                tsk.OwnerId = opp.OwnerId;
                tsk.WhatId = opp.id;
                tsk.Status = 'New';
                tsk.Priority = 'High';
                taskRecord.add (tsk);
            }
            
        }
        if(!taskRecord.isEmpty() && taskRecord != null)
        {
            insert taskRecord;
        }
    }
    
}