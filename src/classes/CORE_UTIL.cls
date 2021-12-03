public class CORE_UTIL {

    public static Map<String, Schema.SobjectType> schemaMap = Schema.getGlobalDescribe();

    public CORE_UTIL() {

    }

    public static List<CORE_CONFDAOWrapper> generateConfigDAOList(List<CORE_DAO_Config__c> cfgRecords){
        List<CORE_CONFDAOWrapper> cfgWrapperList = null;

        if(cfgRecords != null && cfgRecords.size() > 0){
            cfgWrapperList = new List<CORE_CONFDAOWrapper>();
            for(CORE_DAO_Config__c cfg : cfgRecords){
                CORE_CONFDAOWrapper cfgW = new CORE_CONFDAOWrapper(cfg);
                cfgWrapperList.add(cfgW);
                CORE_Constants.nameCfgWrapper.put(cfgW.SobjectAPI,cfgW);
            }

            return cfgWrapperList;
        }
        return null;
    }

    //generate the dynamic field query
    public static  String fieldsQueryString(String objName, String lookupField, String fieldsList, String queryCondition){
        // return query string
        String queryString = CORE_Constants.SELECT_CLAUSE;
        String curqueryCondition = '';

        if(String.isBlank(fieldsList)){
            List<Schema.SObjectField> fieldMapValues = schemaMap.get(objName).getDescribe().fields.getMap().values();
            if(fieldMapValues != null){
                for(Schema.SObjectField f : fieldMapValues){
                    Schema.DescribeFieldResult fr = f.getDescribe();
                    if(fr.isAccessible()){
                        String fieldName=f.getDescribe().getName();
                        if(!String.isBlank(fieldName)){
                            queryString += fieldName+',';
                        }
                    }
                    
                }

                // Strip off the last comma if it exists.
                if (queryString.subString(queryString.Length()-1,queryString.Length()) == ',') {
                    queryString = queryString.subString(0,queryString.Length()-1);
                }

            }
        }

        else{
            queryString += fieldsList;
        }

        queryString += CORE_Constants.FROM_CLAUSE + objName;

        if(!String.isBlank(queryCondition)){
            if(queryCondition.toLowerCase().startsWith('limit')){
                queryString+=' '+queryCondition;
            }
            else{
                queryString += CORE_Constants.WHERE_CLAUSE+queryCondition;
            }
        }

        System.debug('queryString>>>'+queryString);
        return queryString;
    }
    
    
}