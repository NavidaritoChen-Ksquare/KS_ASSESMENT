trigger AccountTrigger on Account (after update) {
     Switch on Trigger.operationType {
        when AFTER_UPDATE {
            AccountBackEndPracticeHelper.HelperMethod(TRIGGER.NEW);
        }
      
    }
}