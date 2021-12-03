/**************************************************************
 * @ provide service :
 * 
 * @ init metadata for feature sobject
 * @ init records per object
 * @ return records json.
 * @ build dynamic query string
 *
 * ***********************************************************/

public class CORE_SOBJECTDAO implements CORE_IDAO{

    // add schema for gloab reference
    public Map<String, Schema.SobjectType> schemaMap = CORE_UTIL.schemaMap;
    
    // current Sobject (will depricate)
    public String objName {get; set;}

    // mapping with config
    public CORE_CONFDAOWrapper config {get; set;}
    
    // current sobject SObjectType
    public Schema.sObjectType sObjectType {get; set;}

    
    // parent Sobjects
    public List<CORE_SOBJECTDAO> parentsSobj {get; set;}
    
    // children Sobjects
    public List<CORE_SOBJECTDAO> childrenSobj {get; set;}

    // Sobject field list - Map<objName, fields>
    public Map<String,Schema.SObjectField> fieldsMap {get; set;}

    // return records for current Sobject
    public List<Sobject> records {get; set;}

    // get records JSON String for current Sobject
    public String recordsJsonString {get; set;}

    // record query string
    public String sobjectQuery {get; set;}


    public CORE_SOBJECTDAO(CORE_CONFDAOWrapper config) {
        this.config = config;
        this.objName = this.config.SobjectAPI;

        // init object

    }

    /***********************************************
     * implements Interface methods
     * 
     ****************************************/
    public void mdataInitialization(Schema.SObjectType objType){
        
    }

    public void mdataInitialization(){
        this.sObjectType = schemaMap.get(this.objName);
        this.fieldsMap = schemaMap.get(this.objName).getDescribe().fields.getMap();

        this.parentsSobj = new List<CORE_SOBJECTDAO>();
        this.childrenSobj = new List<CORE_SOBJECTDAO>();

        /******
         * metadata init
         */
        sobjectFieldInitilization();
        this.sobjectQuery = CORE_UTIL.fieldsQueryString(this.objName,null,this.config.fieldsList,this.config.queryCriteria);
    }


    /***********************************************
     * implements Interface methods
     * 
     ****************************************/
    public void recordsInitialization(Map<String, List<Sobject>> recordsData){
        this.records = new List<Sobject>();
        if(recordsData.keySet() != null && recordsData.keySet().contains(this.objName)){
            this.records.addAll(recordsData.get(this.objName));
        }
    }


    /******************************************************
     * @ Utility methods for SOBJECT_DAO
     * 
     ***************************************************/
    public void sobjectFieldInitilization(){
        // looking for lookup field and find related parent
        if(fieldsMap != null){
            for(Schema.SObjectField sf : fieldsMap.Values()) {
                schema.describeFieldResult dfr = sf.getDescribe();
                if(String.valueOf(dfr.getType()).toLowerCase() == 'reference'){
                    for(Schema.sObjectType sobjectType : dfr.getReferenceTo()){
                        String refObjName = sobjectType.getDescribe().getName();
                            
                            CORE_CONFDAOWrapper relatedCfgWrapper = CORE_Constants.nameCfgWrapper.get(refObjName);

                            if(!String.isBlank(refObjName) && relatedCfgWrapper != null && this.objName != refObjName){
                                CORE_SOBJECTDAO pCoreSobectDAO = new CORE_SOBJECTDAO(relatedCfgWrapper);
                                pCoreSobectDAO.mdataInitialization();
                                parentsSobj.add(pCoreSobectDAO);
                            }
                    }
                }
            }

        }
    }



}