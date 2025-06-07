trigger OpportunityTrigger on Opportunity (after update,before Update,after delete,before insert) {

    if(trigger.isafter && trigger.isUpdate)
    {
        OpportunityTriggerHandler.createTaskforPriviligedUsers(trigger.new);
    }
    if (trigger.isUpdate && trigger.isbefore)
    {
        OpportunityTriggerHandler.updateAmount(trigger.new,trigger.oldMap);
    }
    if(trigger.isafter && trigger.isdelete)
    {
        OpportunityTriggerHandler.createTask(trigger.old);
    }
    if(trigger.isbefore && trigger.isinsert)
    {

        OpportunityTriggerHandler.updateDesrciption(trigger.new);
    }

}