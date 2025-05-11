trigger AccountTrigger on Account (before update) {

    if(trigger.isupdate && trigger.isbefore)
    {
        AccountTriggerHandler.showError(trigger.new , trigger.oldMap);
    }

}