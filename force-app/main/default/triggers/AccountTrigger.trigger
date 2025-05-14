trigger AccountTrigger on Account (before update,after update,after insert) {

    if(trigger.isupdate && trigger.isbefore)
    {
        AccountTriggerHandler.showError(trigger.new , trigger.oldMap);
    }
    if(trigger.isupdate && trigger.isafter)
    {
        AccountTriggerHandler.updateContatWebsite(trigger.new,trigger.oldMap);
    }

}