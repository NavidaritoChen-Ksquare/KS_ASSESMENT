@isTest
public class AccountTriggerTest {
    @isTest
    public static void updateRelatedContactTest(){
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acc.Phone = '123456';
            accList.add(acc);
        }
        test.startTest();
        insert accList;
        
        for(Account acc : accList){
            Contact con = new Contact(LastName=acc.Name);
            con.AccountId = acc.Id;
            conList.add(con);
        }
        insert conList;
        
        for(Account acc:accList){
            acc.Push_To_Vendor__c='Yes';
        }
        update accList;
        test.stopTest();
        
        List<Contact> updatedConList = [select Id,Push_Date__c from Contact where id=:conList[0].Id];
        System.assert(datetime.now().isSameDay(updatedConList[0].Push_Date__c));
        
       
    }
    
    @isTest
    public static void updateRelatedContactTest2(){
        
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        
        for(Integer i=1;i<=2;i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acc.Phone = '123456';
            accList.add(acc);
        }
        
        test.startTest();
        insert accList;
        
        for(Account acc : accList){
            for(integer i=1;i<250;i++){
                Contact con = new Contact(LastName=acc.Name+i);
                con.AccountId = acc.Id;
                conList.add(con);
            }
        }
        insert conList;
        
        for(Account acc:accList){
            acc.Push_To_Vendor__c='Yes';
        }
        update accList;
        test.stopTest();
        List<Contact> updatedConList1 = [select Id,Push_Date__c from Contact where id=:conList[0].Id];
        
        System.assert(datetime.now().isSameDay(updatedConList1[0].Push_Date__c));
       //System.assertEquals(null, updatedConList1[0].Push_Date__c);
        
    }
    
    @isTest
    public static void updateRelatedContactTest3(){
        
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acc.Phone = '123456';
            accList.add(acc);
        }
        
        test.startTest();
        insert accList;
        
        for(Account acc : accList){
            for(integer i=1;i<1001;i++){
                Contact con = new Contact(LastName=acc.Name+i);
                con.AccountId = acc.Id;
                conList.add(con);
            }
        }
        insert conList;
        
        for(Account acc:accList){
            acc.Push_To_Vendor__c='Yes';
        }
        update accList;
        test.stopTest();
        List<Contact> updatedConList1 = [select Id,Push_Date__c from Contact where id=:conList[0].Id];
        
        System.assert(datetime.now().isSameDay(updatedConList1[0].Push_Date__c));
       //System.assertEquals(null, updatedConList1[0].Push_Date__c);
        
    }
    
    @isTest
    public static void updateRelatedContactTest4(){
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        
        for(Integer i=1;i<=5;i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acc.Phone = '123456';
            accList.add(acc);
        }
        test.startTest();
        insert accList;
        
        for(Account acc : accList){
            Contact con = new Contact(LastName=acc.Name);
            con.AccountId = acc.Id;
            conList.add(con);
        }
        insert conList;
        
        for(Account acc:accList){
            acc.Push_To_Vendor__c='No';
        }
        update accList;
        test.stopTest();
        
        List<Contact> updatedConList = [select Id,Push_Date__c from Contact where id=:conList[0].Id];
        System.assertEquals(null, updatedConList[0].Push_Date__c);
        
       
    }

}