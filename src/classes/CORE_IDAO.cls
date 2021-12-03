/*****************************************
 * IDAO, provide core method for all implemented
 * DAO class
 * 
 * @ created Aug,25, 2021
 * 
 *****************************************/
public Interface CORE_IDAO {
    /*********************
     * metadata, init
     * 
     ********/
    void mdataInitialization(Schema.SObjectType objType);

    void mdataInitialization();


    /*************************************
     * records init
     * 
     **********/
    void recordsInitialization(Map<String, List<Sobject>> recordsData);
}