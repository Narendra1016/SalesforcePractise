trigger LeadTrigger on Lead (before update) {

    if(trigger.isupdate && trigger.isbefore)
    {
        LeadTriggerHandler.updateLeadStatus(trigger.new);
    }

}