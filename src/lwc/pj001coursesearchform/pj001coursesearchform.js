import { LightningElement, track } from 'lwc';
import getAllCourseLevels from "@salesforce/apex/LWC001_ApexCourseSearchController.getAllCourseLevels";
import getAllCoursePositions from "@salesforce/apex/LWC001_ApexCourseSearchController.getAllCoursePositions";

export default class Pj001coursesearchform extends LightningElement {

    @track
    selectedCourseLevel = "";

    @track
    selectedCoursePosition = "";

    @track
    courseLevelOptions = [];

    @track
    coursePositionOptions = [];



    @track
    courseLevelOptionsDisabled = true;

    async loadCourseLevels(){
        this.courseLevelOptions = [
            {
                label : "Loading Course Levels...",
                value : ""
            }
        ];

        try{
            const courseLevels = await getAllCourseLevels();
            const levelOptions = courseLevels.map(r => {
                return {
                    label : r.Name,
                    value : r.Id
                };
            });

            levelOptions.unshift({
                label: "All Types",
                value: ""
            });

            this.courseLevelOptions = levelOptions;
            this.courseLevelOptionsDisabled = false;
        }

        catch(error){
            this.courseLevelOptions = [{
                label: "Error loading Course types",
                value: ""
            }];
        }
    }

    async loadCoursePositions(){
        this.coursePositionOptions = [
            {
                label : "Loading Course Positions...",
                value : ""
            }
        ];

        try{
            const coursePostions = await getAllCoursePositions();
            const positionOptions = coursePostions.map(r => {
                return {
                    label: r.Name,
                    value: r.Id
                };
            });

            positionOptions.unshift({
                label: "All Types",
                value: ""
            });

            this.coursePositionOptions = positionOptions;
        }

        catch(error){

        }
    }

    async connectedCallback(){
        this.loadCourseLevels();
        this.loadCoursePositions();

    }


    onFormSubmit() {
        this.dispatchEvent(new CustomEvent("formsubmit", {
            detail: {
                courseLevelId: this.selectedCourseLevel,
                coursePositionId : this.selectedCoursePosition
            }
        }));
    }


    onCourseLevelChange(event){
        this.selectedCourseLevel = event.detail.value;
    }

    onCoursePositionChange(event){
        this.selectedCoursePosition = event.detail.value;
    }
}