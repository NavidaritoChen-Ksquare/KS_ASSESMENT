public with sharing class ContactController {
    public ContactController() {

    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> displayContactRecords (string searchKey){
     
            String searchWord='%'+searchKey+'%';
            List<Contact> conList = new List<Contact>();
        
            if(Contact.SObjectType.getDescribe().isAccessible() && Schema.SObjectType.Contact.fields.Email.isAccessible()) {
                  
               // for (Contact con : [select Name,Email,Phone from Contact where AccountId = :accId AND Name Like :searchWord WITH SECURITY_ENFORCED]) {
                for (Contact con : [select Name,Email,Phone from Contact where  Name Like :searchWord ]) {
                    conList.add(con);
                }
    
            }
      
            return conList;
     
    }
}