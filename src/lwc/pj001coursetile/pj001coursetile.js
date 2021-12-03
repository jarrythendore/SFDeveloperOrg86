import { api, LightningElement, track } from 'lwc';

export default class Pj001coursetile extends LightningElement {

    @api
    course;

    @api
    selectedId;

    onClick() {
        // component event
        this.dispatchEvent(new CustomEvent("select", {
            detail: {
                course: { ...this.course } // copy this.course to course (event passing parameters)
            }
        }));
    }

    
}