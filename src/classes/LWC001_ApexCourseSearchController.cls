public  class LWC001_ApexCourseSearchController {
    public LWC001_ApexCourseSearchController() {

    }

    @AuraEnabled
    public static List<LWC_CourseLevel__c> getAllCourseLevels(){
        try {
            return [SELECT 
                            Id,
                            Name 
                    FROM 
                            LWC_CourseLevel__c];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
            
        }
    }


    @AuraEnabled
    public static List<LWC_CoursePosition__c> getAllCoursePositions(){
        try {
            return [SELECT 
                            Id,
                            Name 
                    FROM 
                            LWC_CoursePosition__c];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
            
        }
    }

}