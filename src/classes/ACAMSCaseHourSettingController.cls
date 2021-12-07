public with sharing class ACAMSCaseHourSettingController {
    public List<BusinessHours> hoursList {get;set;}
    public List<CaseHoursSetting__c> settingList {get;set;}
    public CaseHoursSetting__c currSetting {get;set;}

    public String currSettingId  {get; set{currSettingId = value;}}

    public Map<String,CaseHoursSetting__c> settingIdRecordMap {get;set;}

    public ACAMSCaseHourSettingController() {
        hoursList = new List<BusinessHours>();
        settingList = new List<CaseHoursSetting__c>();
        settingIdRecordMap = new Map<String,CaseHoursSetting__c>();
        currSetting = new CaseHoursSetting__c();
    }

    public PageReference doInit(){
        hoursList = ACAMSCaseSettingDAO.getAllBusinessHours();
        settingList = ACAMSCaseSettingDAO.getAllCaseSettingRecords();
        if(settingList != null){
            for(CaseHoursSetting__c setting : settingList){
                settingIdRecordMap.put(String.valueOf(setting.Id),setting);
            }
        }

        return null;
    }
    //FSA-111
    public PageReference insertCaseHourSetting(){
        if(!ACAMSCaseSettingDAO.caseSettingFormatValidation(currSetting)){
            return null;
        }
        settingList.add(currSetting);
        CaseHoursSetting__c duplicate = validateCaseHourSetting(settingList);
        // validate here
        if(duplicate != null){
            settingList.remove(settingList.indexOf(currSetting));
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Duplicate with existing setting - record name: '+duplicate.Name));
            return null;
        }
        upsert settingList;
        settingIdRecordMap.put(currSetting.Id,currSetting);
        PageReference tempPage = ApexPages.currentPage();            
        tempPage.setRedirect(true);
        return tempPage;

        /*
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'error'));
        return null;
        */
    }

    public PageReference editCaseHourSetting(){
        System.debug('---currSettingId--->'+currSettingId);
        if(settingList != null && settingList.size() > 0 && settingIdRecordMap != null && settingIdRecordMap.size() > 0){
            currSetting = settingIdRecordMap.get(currSettingId);
            settingList.remove(settingList.indexOf(settingIdRecordMap.get(currSettingId)));
            settingIdRecordMap.remove(currSettingId);
        }

        return null;
    }

    public PageReference deleteCaseHourSetting(){
        if(settingList != null && settingList.size() > 0){
            Delete [SELECT Id, Name FROM CaseHoursSetting__c WHERE Id =: currSettingId];
            settingList.remove(settingList.indexOf(settingIdRecordMap.get(currSettingId)));
            settingIdRecordMap.remove(currSettingId);
        }


        return null;
    }

    public CaseHoursSetting__c validateCaseHourSetting(List<CaseHoursSetting__c> caseHourSettingList){
        CaseHoursSetting__c result = null;
        for(Integer i = 0; i < caseHourSettingList.size(); i++){
            for(Integer j = i+1; j < caseHourSettingList.size(); j++){
                if(ACAMSCaseSettingDAO.isCaseSettingEqual(caseHourSettingList[i],caseHourSettingList[j])){
                    result = caseHourSettingList[i];
                    break;
                }
            }
        }
        return result;
    }
}