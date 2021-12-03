public with sharing class CCInvoiceDataController {
    public CCInvoiceDataController() {

    }

    @AuraEnabled
    public static List<CC_Invoice__c> getCCInvoiceRecords(){
        return [SELECT 
                    Id, 
                    Name, 
                    Tax_Amount__c, 
                    Tax_Registration_Id__c 
                FROM CC_Invoice__c 
                ];
    }

    @AuraEnabled(cacheable=true)
    public static List<CC_Invoice__c> deleteCCInvoiceRecords(String invoiceId){
        System.debug('------------>'+invoiceId);
        
        List<CC_Invoice__c> invList = [SELECT Id FROM CC_Invoice__c];

        for(CC_Invoice__c item : invList){
            if(String.valueOf(item.Id).equals(invoiceId)){
                invList.remove(invList.indexOf(item));
                break;
            }
        }

        return invList;
    }
}