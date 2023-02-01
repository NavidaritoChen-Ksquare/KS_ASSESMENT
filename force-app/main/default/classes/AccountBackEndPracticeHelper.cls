public class AccountBackEndPracticeHelper {
    public static void HelperMethod(List<Account> AccountList){
        Set<Id> accIds = new Set<Id>();
        
        for (Account acc : AccountList) {
             accIds.add(acc.Id);
        }
        
        Map<Id,Contact> childContacts = new Map<Id,Contact>([SELECT AccountID,Push_Date__c FROM Contact WHERE AccountId IN : accIds]);
   
        List<Contact> conList = new List<Contact>();
        
        if(childContacts.values().size()<=200){
            for(Account acc : AccountList){
                for(Contact con : [SELECT AccountID,Push_Date__c FROM Contact WHERE AccountId IN : accIds]){
                    if(con.AccountID == acc.Id && acc.Push_To_Vendor__c == 'Yes' ){
                    	con.Push_Date__c = Date.today();
                        conList.add(con);
                    }else if(con.AccountID == acc.Id && acc.Push_To_Vendor__c == 'No' ){
                        con.Push_Date__c = null;
                        conList.add(con);
                    }
                }
            }
        }else if(childContacts.values().size()<=1000 && childContacts.values().size()>200){
            Database.executeBatch(new BatchUpdateAccountContacts(AccountList));
        }else if(childContacts.values().size()>1000){
            Database.executeBatch(new BatchUpdateAccountContacts(AccountList),150);
        }
        
        if(conList.size()>0){
            update conList;
        }
    }
}