public  class CORE_CONFDAOWrapper {

    public CORE_DAO_Config__c daoCfg {get; set;}

    //will depricated
    public CORE_IDAO relatedDAO {get; set;}

    public String SobjectAPI {get; set;}
    public Set<String> queryFieldsAPI {get; set;}
    public String fieldsList {get; set;}
    public String queryCriteria {get; set;}

    public CORE_CONFDAOWrapper(CORE_DAO_Config__c daoCfg) {
        this.daoCfg = daoCfg;
        init();
        
    }

    public void init(){
        if(!String.isBlank(daoCfg.CORE_DAO_ObjectAPI__c)){
            this.SobjectAPI = String.valueOf(daoCfg.CORE_DAO_ObjectAPI__c).trim();
        }
        this.queryFieldsAPI = fetchQueryFieldsAPI();
        addedQueryCriteria();
    }

    public void execute(){

    }

    /****************************************************
     * @ utility methods
     * 
     ***********************************************/
    public Set<String> fetchQueryFieldsAPI(){
        if(!String.isBlank(this.daoCfg.CORE_DAO_FieldsAPI__c)){
            this.fieldsList = String.valueOf(this.daoCfg.CORE_DAO_FieldsAPI__c).trim();
            String qryString = fieldsList;
            Set<String> returnFdsAPI = new Set<String>();
            List<string> fieldsAPI = qryString.split(',');
            returnFdsAPI.addAll(fieldsAPI);
            return returnFdsAPI;
        }
        return null;
    }


    /******************************************************
     *@ compose query criterias
     * 
     ****************************************************/
    public void addedQueryCriteria(){
        if(!String.isBlank(this.daoCfg.CORE_DAO_QueryCriteria__c)){
            this.queryCriteria = String.valueOf(this.daoCfg.CORE_DAO_QueryCriteria__c).trim();
        }
        
    }
}