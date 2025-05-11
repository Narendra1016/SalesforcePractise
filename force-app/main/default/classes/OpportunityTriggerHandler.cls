public with sharing class OpportunityTriggerHandler {
    /**
     * Author : Narendra Sontakke
     * Description : opportunity Trigger
     */
    // if opportunity stageName is closedWon then create a task
    public static void createTaskforPriviligedUsers(List<Opportunity> newRecords)
    {
        try{
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
        catch(Exception e)
        {
            system.debug(e.getMessage());
        }
    }  

    // if opportunity stage is modified the calculate Amount based on probability & expected revenue

    public static void updateAmount(List<Opportunity>newRecords, Map<Id,Opportunity> oldRecords)
    {
        try{
            for (opportunity opp:newRecords)
            {
                if(oldRecords.get(opp.id).StageName != opp.StageName)
                {
                    opp.Amount = opp.Probability * opp.ExpectedRevenue;
                }
            }
        }
        catch(Exception e)
        {
            system.debug(e.getMessage());
        }

    }
}