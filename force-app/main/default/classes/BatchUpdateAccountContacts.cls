global class BatchUpdateAccountContacts implements Database.Batchable<sObject>{
	Set<Id> accIds = new Set<Id>();
    List<Contact> conListUpdate = new List<Contact>();
    List<Account> accList = new List<Account>();
    global BatchUpdateAccountContacts(List<Account> AccountList){
        for (Account acc : AccountList) {
             accIds.add(acc.Id);
        }
        accList=AccountList;
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([SELECT AccountID,Push_Date__c FROM Contact WHERE AccountId IN : accIds ]);
    }
    global void execute(Database.BatchableContext BC, List<Contact> conList){
         for(Account acc : accList){
                for(Contact con : conList){
                    if(con.AccountID == acc.Id && acc.Push_To_Vendor__c == 'Yes' ){
                    	con.Push_Date__c = Date.today();
                        conListUpdate.add(con);
                    }else if(con.AccountID == acc.Id && acc.Push_To_Vendor__c == 'No' ){
                        con.Push_Date__c = null;
                        conListUpdate.add(con);
                    }
                }
           }
        if(conListUpdate.size()>0){
            update conListUpdate;
        }
        
    }
    global void finish(Database.BatchableContext BC){
        
    }
}