trigger ContactTrigger on Contact (before insert) {
    if(trigger.isinsert && trigger.isbefore)
    {
        ContactTriggerHandler.showError(trigger.new);
    }

}