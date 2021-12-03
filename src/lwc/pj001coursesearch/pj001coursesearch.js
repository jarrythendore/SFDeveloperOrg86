import { LightningElement } from 'lwc';

export default class Pj001coursesearch extends LightningElement {

    onFormSubmit(event){
        //alert(`-- Form Submit: ${JSON.stringify(event.detail)}`);
        this.template.querySelector("c-pj001coursesearchresults").search(event.detail.courseLevelId, event.detail.coursePositionId);
    }
}