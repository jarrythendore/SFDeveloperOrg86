@isTest
public with sharing class ACAMSCaseHourSettingControllerTest {
    @TestSetup
    static void makeData(){
        Profile p = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        User u = new User(Alias = 'standt', Email = 'standarduser@testorg.com',
            EmailEncodingKey = 'UTF-8', LastName = 'Testing', LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', ProfileId = p.Id,
            TimeZoneSidKey = 'America/Los_Angeles', UserName = 'lmsintegration@acams2.org.acams');
        insert u;

        List<CaseHoursSetting__c> settingList = new List<CaseHoursSetting__c>();
        CaseHoursSetting__c stdSetting = new CaseHoursSetting__c();
        stdSetting.Name = 'US Case';
        stdSetting.Business_Hour_Name__c = 'Support Hours';
        stdsetting.Case_Origin__c = 'Email';
        stdSetting.Owner_Type__c = 'User';
        stdSetting.ownerId = u.Id;

        settingList.add(stdSetting);

        CaseHoursSetting__c apacSetting = new CaseHoursSetting__c();
        apacSetting.Name = 'Asia Case';
        apacSetting.Business_Hour_Name__c = 'APAC Hours';
        apacSetting.Case_Origin__c = 'Email';
        apacSetting.Owner_Type__c = 'Queue';
        apacSetting.Queue_Name__c = 'APAC Urgent';
        settingList.add(apacSetting);

        CaseHoursSetting__c emeaSetting = new CaseHoursSetting__c();
        emeaSetting.Name = 'emea Case';
        emeaSetting.Business_Hour_Name__c = 'EMEA Hours';
        emeaSetting.Case_Origin__c = 'Email';
        emeaSetting.Owner_Type__c = 'Functional Area';
        emeaSetting.Queue_Name__c = 'APAC Urgent';
        settingList.add(emeaSetting);

        insert settingList;

    }

    @IsTest
    static void testControllerMethod(){
        Test.startTest();
        List<CaseHoursSetting__c> settingList = ACAMSCaseSettingDAO.getAllCaseSettingRecords();

        ACAMSCaseHourSettingController hourCtr = new ACAMSCaseHourSettingController();
        hourCtr.currSettingId = settingList[0].Id;
        System.debug('----->'+settingList[0].Id);
        hourCtr.doInit();
        hourCtr.insertCaseHourSetting();
        hourCtr.editCaseHourSetting();
        //hourCtr.deleteCaseHourSetting();
        hourCtr.validateCaseHourSetting(ACAMSCaseSettingDAO.getAllCaseSettingRecords());
        Test.stopTest();
    }

}