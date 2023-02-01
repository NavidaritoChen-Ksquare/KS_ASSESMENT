@isTest
public class ContactControllerTest {
	
    @isTest
    public static void displayContactRecordsTest(){
    	List<Contact> conList = new List<Contact>();
        List<Contact> conList1 = new List<Contact>();
        test.startTest();
        conList = ContactController.displayContactRecords('j','001Dn00000EPP5yIAH');
        test.stopTest();
        conList1= [select Name,Email,Phone from Contact where AccountId = '001Dn00000EPP5yIAH' AND Name Like '%j%'];
        System.assertEquals(conList, conList1);
    }
}