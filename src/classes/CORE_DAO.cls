public  class CORE_DAO implements CORE_IDAO{
    
    // get global Sobject info
    public Map<String, Schema.SobjectType> schemaMap = CORE_UTIL.schemaMap;

    // Set of Sobject names
    public Set<String> objNames {get; set;}

    // list of Core_SobjectDao
    public List<CORE_SOBJECTDAO> sobjectDAOList {get; set;}

    // list of CORE_CONFDAOWrapper
    public List<CORE_CONFDAOWrapper> configDAOList {get; set;}

    // total records
    public Map<String, List<Sobject>> allDataRecords {get; set;}

    
    public CORE_DAO(List<CORE_CONFDAOWrapper> configDAOList) {
        this.configDAOList = configDAOList;
    }


    /***********************************************
     * implements Interface methods
     * 
     ****************************************/
    public void mdataInitialization(Schema.SObjectType objType){

    }

    public void mdataInitialization(){
        this.sobjectDAOList = new List<CORE_SOBJECTDAO>();

        if(configDAOList != null && configDAOList.size() > 0){
            for(CORE_CONFDAOWrapper cfgW : configDAOList){
                if(!String.isBlank(cfgW.SobjectAPI)){
                    CORE_SOBJECTDAO objDAO = new CORE_SOBJECTDAO(cfgW);
                    objDAO.mdataInitialization();
                    sobjectDAOList.add(objDAO);
                }
            }
        }
    }


    /*********************************************************************
     * implements Interface methods
     * 
     ****************************************/
    public void recordsInitialization(Map<String, List<Sobject>> recordsData){
        recordsData = new Map<String,List<Sobject>>();
        if(sobjectDAOList != null && sobjectDAOList.size() > 0){
            for(CORE_SOBJECTDAO cDAO : sobjectDAOList){
                if(!recordsData.keySet().contains(cDAO.objName)){
                    recordsData.put(cDAO.objName, new List<Sobject>());
                }
                
                if(!String.isBlank(cDAO.sobjectQuery)){
                    List<Sobject> records = Database.query(cDAO.sobjectQuery);
                    recordsData.get(cDAO.objName).addAll(records);
                    cDAO.recordsInitialization(recordsData);
                }
            }
            
        }
        this.allDataRecords = recordsData;
    }


    /***********************************************************************
     *  @ utility method
     * 
     ****************************/
    public CORE_CONFDAOWrapper getConfigWrapperByObjName(){

        for(CORE_CONFDAOWrapper cfgWrapper : configDAOList){
            
        }

        return null;
    }


}