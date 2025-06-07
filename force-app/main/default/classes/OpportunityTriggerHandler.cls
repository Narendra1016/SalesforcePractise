public with sharing class OpportunityTriggerHandler {
    /**
     * Author : Narendra Sontakke
     * Description : opportunity Trigger
     */
    // if opportunity stageName is closedWon then create a task



    // update Desription as opportunity creation

    public static void updateDesrciption (List<Opportunity> newRecords)
    {
        for(Opportunity opp :newRecords)
        {
            if(opp.Amount != null && opp.Amount >100000)
            {
                opp.Description = 'Hot Opportunity';
            }
        }
    }  
    public static void createTaskforPriviligedUsers(List<Opportunity> newRecords)
    {
        set<Id> closeLostId = new Set<Id>();
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
                else if(opp.StageName =='Closed Lost')
                {
                    closeLostId.add(opp.Id);
                }      
            }

            if(!closeLostId.isEmpty()){

                List<OpportunityTeamMember> oppTeam = [SELECT Id FROM OpportunityTeamMember WHERE OpportunityId  IN: closeLostId];

                if(!oppTeam.isEmpty() && oppTeam != null)
                {
                    delete oppTeam;
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

    public static void createTask(List<Opportunity> oldRecords)
    
    {
        Map<Id,Id>  oppMap = new Map<Id,Id>();
        Map<Id,Id>  accMap = new Map<Id,Id>();
        List<Task> taskList = new List<Task>();
        for(Opportunity opp:oldRecords)
        {
            oppMap.put(opp.Id,opp.AccountId);
        }


        List<Account> accList = [SELECT Id,OwnerId FROM Account WHERE Id IN:oppMap.values()];

        for(account acc:accList)
        {
            accMap.put(acc.Id,acc.OwnerId);
        }

        for(Opportunity opp:oldRecords)
        {
            Task ts = new Task();
            ts.Priority = 'High';   
            ts.Status = 'New';
            ts.Subject = 'Task Created';
            ts.WhatId = opp.AccountId;
            ts.OwnerId = accMap.get(oppMap.get(opp.Id));
            taskList.add(ts);
            
        }
        if(!taskList.isEmpty() && taskList != null)
        {
            insert taskList;
        }
    }
            
}
    
