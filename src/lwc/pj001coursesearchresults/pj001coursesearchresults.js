import { api, LightningElement, track, wire } from 'lwc';
import getCoursesByLevel from "@salesforce/apex/LWC001_ApexCourseSearchResultsController.getCoursesByLevel";

// sibling event parameters
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pj001pubsub';

export default class Pj001coursesearchresults extends LightningElement {
    @track
    courses = [];

    @track
    selectedCourseId;

    @track
    selectedCourse;

    @track
    searchState = {
        searched: false,
        searching: false,
        error: false
    };

    get courseEmpty(){
        return !this.courses || this.courses.length === 0;
    }

    @api
    async search(courseLevelId, coursePositionId){
        //alert('----->'+courseLevelId);
        try{
            //alert('-------->'+coursePositionId);
            this.courses = await getCoursesByLevel({levelId: courseLevelId,coursePosition: coursePositionId});
        }
        catch(error){
            this.searchState.error = error;
        }
    }

    onCourseSelect(event){
        
        this.selectedCourse = event.detail.course;
        //alert('--->'+JSON.stringify(this.selectedCourse));
        if(this.selectedCourse){
            //alert('-->'+this.selectedCourseId);
            fireEvent(this.pageRef,"siblingEvent", { siblingData: this.selectedCourse});
        }

    }

    /*********************************************
     * Sibling event parameters
     * 
     ******/
    @wire(CurrentPageReference) pageRef;




}