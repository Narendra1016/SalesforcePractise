trigger LeadTrigger on Lead (before update,after insert ,before delete) {

    if(trigger.isupdate && trigger.isbefore)
    {
        LeadTriggerHandler.updateLeadStatus(trigger.new);
    }
    if(trigger.isafter && trigger.isInsert)
    {
        LeadTriggerHandler.createTask(trigger.new);
    }
    if(trigger.isbefore && trigger.isdelete)
    {
        LeadTriggerHandler.showError(trigger.old);
    }

}