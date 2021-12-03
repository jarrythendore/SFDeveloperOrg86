import { LightningElement,wire,track, api } from 'lwc';
// event parameters
import { registerListener } from 'c/pj001pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class Pj001coursedetails extends LightningElement {
    @wire(CurrentPageReference) pageRef;

    @track passedCourseId = '000';

    @track passedCourse;

    @api
    fullDetailVisiable = false;

    get selectedCourseEmpty(){
        return !this.passedCourse;
    }

    connectedCallback() {
        registerListener('siblingEvent', this.handleSiblingEvent, this);
    }

    handleSiblingEvent(siblingData){
        // alert('---->'+JSON.stringify(siblingData));
        if(siblingData){
            this.passedCourse = siblingData.siblingData;
            this.fullDetailVisiable = true;
        }
    }
}