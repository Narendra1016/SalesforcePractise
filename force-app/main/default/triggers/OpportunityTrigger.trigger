trigger OpportunityTrigger on Opportunity (after update) {

    if(trigger.isafter && trigger.isUpdate)
    {
        OpportunityTriggerHandler.createTaskforPriviligedUsers(trigger.new);
    }

}