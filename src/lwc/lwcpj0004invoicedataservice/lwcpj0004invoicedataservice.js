import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import { getRecord } from 'lightning/uiRecordApi';
import INVOICE_OBJECT from '@salesforce/schema/CC_Invoice__c';
import NAME_FIELD from '@salesforce/schema/CC_Invoice__c.Name';
import TAXAMOUNT_FIELD from '@salesforce/schema/CC_Invoice__c.Tax_Amount__c';
import TAXID_FIELD from '@salesforce/schema/CC_Invoice__c.Tax_Registration_Id__c';

import { getRecord } from 'lightning/uiRecordApi';

import getCCInvoiceRecords from '@salesforce/apex/CCInvoiceDataController.getCCInvoiceRecords';

const FIELDS = [
    NAME_FIELD, 
    TAXAMOUNT_FIELD, 
    TAXID_FIELD
];


export default class Lwcpj0004invoicedataservice extends LightningElement {
    
    customF = [NAME_FIELD, TAXAMOUNT_FIELD, TAXID_FIELD];

    @api objAPIName = INVOICE_OBJECT;

    @api recordId;
    
    @track invoiceRecord;

    error;

    // insert an invoice
    createInvoice(evt){
        const toastEvent = new ShowToastEvent({
            title: "Invoice created",
            message: "Record ID: " + evt.detail.id,
            variant: "success"
        });
        
        this.recordId = evt.detail.id;

        this.dispatchEvent(toastEvent);
    }

  

    
    @wire(getRecord, { recordId: '$recordId', fields: [FIELDS] })
    wiredRecord({data, error}) {
        //console.log('Execute logic each time a new value is provisioned');
        if (data) {
            this.invoiceRecord = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.invoiceRecord = undefined;
        }
    }
    
}