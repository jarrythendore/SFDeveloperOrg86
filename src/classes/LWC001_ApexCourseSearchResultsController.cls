public with sharing class LWC001_ApexCourseSearchResultsController {
    public LWC001_ApexCourseSearchResultsController() {

    }

    @AuraEnabled
    public static List<LWC_Course__c> getCoursesByLevel(String levelId, String coursePosition){
        
        if(!String.isBlank(levelId) && !String.isBlank(coursePosition)){
            try {
                return [SELECT 
                                Id,
                                Name,
                                LWC_Category__c,
                                LWC_Completion__c,
                                LWC_CourseLevel__c,
                                LWC_CoursePosition__c,
                                LWC_Description__c
                        FROM 
                            LWC_Course__c 
                        WHERE 
                            LWC_CourseLevel__c =: levelId 
                        AND
                        LWC_CoursePosition__c =: coursePosition];
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }

        else if(!String.isBlank(levelId)){
            try {
                return [SELECT 
                                Id,
                                Name,
                                LWC_Category__c,
                                LWC_Completion__c,
                                LWC_CourseLevel__c,
                                LWC_CoursePosition__c,
                                LWC_Description__c
                        FROM 
                            LWC_Course__c 
                        WHERE 
                            LWC_CourseLevel__c =: levelId ];
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }

        else if(!String.isBlank(coursePosition)){
            try {
                return [SELECT 
                                Id,
                                Name,
                                LWC_Category__c,
                                LWC_Completion__c,
                                LWC_CourseLevel__c,
                                LWC_CoursePosition__c,
                                LWC_Description__c
                        FROM 
                            LWC_Course__c 
                        WHERE 
                        LWC_CoursePosition__c =: coursePosition];
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }

        else{
            try {
                return [SELECT 
                                Id,
                                Name,
                                LWC_Category__c,
                                LWC_Completion__c,
                                LWC_CourseLevel__c,
                                LWC_CoursePosition__c,
                                LWC_Description__c
                        FROM 
                            LWC_Course__c 
                        ORDER BY
                            Name];
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
    }
}