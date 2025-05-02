trigger TaskTrigger on Task (before insert) {

    if(trigger.isbefore && trigger.isInsert)
    {
        TaskTriggerHandler.updatePriority(trigger.new);
    }

}