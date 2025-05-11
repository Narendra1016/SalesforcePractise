trigger LeadTrigger on Lead (before update,after insert) {

    if(trigger.isupdate && trigger.isbefore)
    {
        LeadTriggerHandler.updateLeadStatus(trigger.new);
    }
    if(trigger.isafter && trigger.isInsert)
    {
        LeadTriggerHandler.createTask(trigger.new);
    }


}