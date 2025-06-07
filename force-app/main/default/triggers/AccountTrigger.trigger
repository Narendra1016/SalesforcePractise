trigger AccountTrigger on Account (before update,after update,after insert,before insert) {

    if(trigger.isupdate && trigger.isbefore)
    {
        AccountTriggerHandler.showError(trigger.new , trigger.oldMap);
    }
    if(trigger.isupdate && trigger.isafter)
    {
        AccountTriggerHandler.updateContatWebsite(trigger.new,trigger.oldMap);
    }
    if(trigger.isafter && trigger.isinsert )
    {
        AccountTriggerHandler.createContats(trigger.new);
    }
    if(trigger.isbefore && trigger.isInsert)
    {
        AccountTriggerHandler.updateRating(trigger.new);
    }

}