public class CORE_CONFDAO {
    public CORE_CONFDAO() {

    }


    public static List<CORE_DAO_Config__c> getAllActiveCONFRcords(){
        return 
        [
            SELECT 
                    Id, 
                    Name,
                    CORE_DAO_ObjectAPI__c,
                    CORE_DAO_FieldsAPI__c,
                    CORE_DAO_QueryCriteria__c,
                    Active__c
            FROM 
                    CORE_DAO_Config__c
            WHERE
                    Active__c = true
            LIMIT 
                    100                
            ];
    }
}