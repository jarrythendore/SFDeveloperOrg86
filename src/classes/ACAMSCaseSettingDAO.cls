/**
 * @FSA-355
 */
public with sharing class ACAMSCaseSettingDAO {

    public static List<CaseHoursSetting__c> getAllCaseSettingRecords(){
        List<CaseHoursSetting__c> caseHourSettingRecords = [
            SELECT Id,
                Name,
                Business_Hour_Name__c,
                Calculated_Hours__c,
                Case_Origin__c,
                Case_Owner__c,
                Case_Type_Name__c,
                Secondary_Case_Type__c, // FSA-818
                Functional_Area__c,
                Owner_Type__c,
                Queue_Name__c

            FROM
            CaseHoursSetting__c
            LIMIT 500
        ];

        return caseHourSettingRecords;
    }

    /**
     * @ return the user id or queue or function area
     */

     /*
    public static String findCaseOwner(CaseHoursSetting__c settingRec){
        if(String.valueOf(settingRec.Owner_Type__c).equalsIgnoreCase('user')){
            return settingRec.Case_Owner__c;
        }
        else if(String.valueOf(settingRec.Owner_Type__c).equalsIgnoreCase('queue')){
            return settingRec.Queue_Name__c;
        }
        else if(String.valueOf(settingRec.Owner_Type__c).equalsIgnoreCase('functional area')){
            return settingRec.Functional_Area__c;
        }
        return null;
    }
    */
    /**
     * @ return case support business hour
     */
    public static String caseSupportBusinessHour(Case targetCase){
        if(String.valueOf(targetCase.Origin).containsIgnoreCase('APAC') || String.valueOf(targetCase.Origin).containsIgnoreCase('Asia')){
               return 'APAC Hours';
        }
        else if(String.valueOf(targetCase.Origin).containsIgnoreCase('EMEA') || String.valueOf(targetCase.Origin).containsIgnoreCase('Europe')){
               return 'EMEA Hours';
        }
        else if(String.valueOf(targetCase.Origin).containsIgnoreCase('Contact Us Form') || String.valueOf(targetCase.Origin).containsIgnoreCase('US Collections')){
               return 'Support Hours';
        }
        else{
            return 'Region_TBD';
        }
    }

    /**
     * @ return the owner_type, (case_Owner, Queue_name and functional area) compare result
     */
    public static Boolean compareCaseSettingOwnerType(Case targetCase, CaseHoursSetting__c targetCaseSetting){
        Boolean compareRes = false;
        if(targetCaseSetting.Owner_Type__c == 'User'){
            if(targetCaseSetting.Case_Owner__c != null && targetCase.ownerId != null && targetCase.ownerId == targetCaseSetting.Case_Owner__c){
                compareRes = true;
            }
        }
        else if(targetCaseSetting.Owner_Type__c == 'Queue'){
            System.debug('queue picklist value ------>'+targetCaseSetting.Queue_Name__c);
            if(targetCaseSetting.Queue_Name__c != null && targetCase.ownerId != null && targetCase.ownerId == targetCaseSetting.Queue_Name__c){
                compareRes = true;
            }
        }
        else if(targetCaseSetting.Owner_Type__c == 'Functional Area'){
            if(targetCase.ownerId != null && targetCase.Case_Owner_Functional_Area__c != null && targetCaseSetting.Functional_Area__c != null){
                if(targetCase.Case_Owner_Functional_Area__c == targetCaseSetting.Functional_Area__c){
                    compareRes = true;
                }
            }
        }
        return compareRes;
    }

    /**
     * @ get all business hours
     */
    public static List<BusinessHours> getAllBusinessHours(){
        List<BusinessHours> hoursList = [SELECT Id,Name FROM BusinessHours WHERE Name = 'Support Hours' OR Name = 'EMEA Hours' OR Name = 'APAC Hours'];
        return hoursList;
    }

    /**
     * @ check two case setting are equal
     */
    public static Boolean isCaseSettingEqual(CaseHoursSetting__c src, CaseHoursSetting__c tar){
        if(src != null && tar != null){
            if(String.valueOf(src.Business_Hour_Name__c).equals(String.valueOf(tar.Business_Hour_Name__c)) && 
            String.valueOf(src.Case_Type_Name__c).equals(String.valueOf(tar.Case_Type_Name__c)) && 
            String.valueOf(src.Owner_Type__c).equals(String.valueOf(tar.Owner_Type__c)) && 
            String.valueOf(src.Secondary_Case_Type__c).equals(String.valueOf(tar.Secondary_Case_Type__c))){ // FSA-818

                if(!String.isBlank(src.Case_Owner__c) && !String.isBlank(tar.Case_Owner__c) && String.valueOf(src.Owner_Type__c).toLowerCase().equals('user') && String.valueOf(src.Case_Owner__c).equals(String.valueOf(tar.Case_Owner__c))){
                    return true;
                }
                else if(!String.isBlank(src.Queue_Name__c) && !String.isBlank(tar.Queue_Name__c) && String.valueOf(src.Owner_Type__c).toLowerCase().equals('queue') && String.valueOf(src.Queue_Name__c).equals(String.valueOf(tar.Queue_Name__c))){
                    return true;
                }
                else if(!String.isBlank(src.Functional_Area__c) && !String.isBlank(tar.Functional_Area__c) && String.valueOf(src.Owner_Type__c).toLowerCase().equals('functional area') && String.valueOf(src.Functional_Area__c).equals(String.valueOf(tar.Functional_Area__c))){
                    return true;
                }
                else{
                    return false;
                }
            }

            else{
                return false;
            }
        }
        return false;
    }

    /**
     * @ case setting format validation
     */
    public static Boolean caseSettingFormatValidation(CaseHoursSetting__c targetSetting){
        if(!String.isBlank(targetSetting.Owner_Type__c) && String.valueOf(targetSetting.Owner_Type__c).toLowerCase().equals('user') && String.isBlank(targetSetting.Case_Owner__c)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'if owner type is user, please fill case owner field and leave Funtional Area, Queue Name fields empty.'));
            return false;
        }
        else if(!String.isBlank(targetSetting.Owner_Type__c) && String.valueOf(targetSetting.Owner_Type__c).toLowerCase().equals('queue') && String.isBlank(targetSetting.Queue_Name__c)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'if owner type is queue, please fill queue name field and leave Funtional Area, Case Owner fields empty.'));
            return false;
        }

        else if(!String.isBlank(targetSetting.Owner_Type__c) && String.valueOf(targetSetting.Owner_Type__c).toLowerCase().equals('functional area') && String.isBlank(targetSetting.Functional_Area__c)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'if owner type is functional area, please fill queue name field and leave Queue Name, Case Owner fields empty.'));
            return false;
        }

        if((!String.isBlank(targetSetting.Functional_Area__c) && !String.isBlank(targetSetting.Queue_Name__c)) || 
        (!String.isBlank(targetSetting.Functional_Area__c) && !String.isBlank(targetSetting.Case_Owner__c)) || 
        (!String.isBlank(targetSetting.Queue_Name__c) && !String.isBlank(targetSetting.Case_Owner__c))){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'please make sure one of three fields (Case Owner, Queue Name and Functional Area) populated ONLY and clear the rest of them.'));
            return false;
        }

        if(targetSetting.Calculated_Hours__c == null || targetSetting.Calculated_Hours__c < 0 || targetSetting.Calculated_Hours__c > 10000){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please input a positive number less than 10000'));
            return false;
        }
        return true;
    }
}

//String.valueOf(src.Queue_Name__c).equals(String.valueOf(tar.Queue_Name__c))
//String.valueOf(src.Functional_Area__c).equals(String.valueOf(tar.Functional_Area__c))