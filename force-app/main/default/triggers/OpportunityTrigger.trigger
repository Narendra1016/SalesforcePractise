trigger OpportunityTrigger on Opportunity (after update,before Update) {

    if(trigger.isafter && trigger.isUpdate)
    {
        OpportunityTriggerHandler.createTaskforPriviligedUsers(trigger.new);
    }
    if (trigger.isUpdate && trigger.isbefore)
    {
        OpportunityTriggerHandler.updateAmount(trigger.new,trigger.oldMap);
    }

}