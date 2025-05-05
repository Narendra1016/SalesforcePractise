trigger CaseTrigger on Case (before insert) {

    if(trigger.isInsert && trigger.isbefore)
    {
        CaseTriggerHandler.updateCase(trigger.new);
    }

}