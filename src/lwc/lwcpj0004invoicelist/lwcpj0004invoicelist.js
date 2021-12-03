import { LightningElement, api, wire, track } from 'lwc';
import INVOICE_OBJECT from '@salesforce/schema/CC_Invoice__c';
import NAME_FIELD from '@salesforce/schema/CC_Invoice__c.Name';
import TAXAMOUNT_FIELD from '@salesforce/schema/CC_Invoice__c.Tax_Amount__c';
import TAXID_FIELD from '@salesforce/schema/CC_Invoice__c.Tax_Registration_Id__c';

import getCCInvoiceRecords from '@salesforce/apex/CCInvoiceDataController.getCCInvoiceRecords';
import deleteCCInvoiceRecords from '@salesforce/apex/CCInvoiceDataController.deleteCCInvoiceRecords';

// using LWC API
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

const columns = [
    { label: 'Invoice Name', fieldName: 'Name', type: 'text' },
    { label: 'Invoice Tax', fieldName: 'Tax_Amount__c', type: 'Number' },
    { label: 'Registration Id', fieldName: 'Tax_Registration_Id__c', type: 'text' },
    {
        label: 'Action', type: 'button', typeAttributes: {
            label: 'Edit',
            name: 'Edit',
            title: 'Edit',
            disabled: false,
            value: 'Edit',
            iconPosition: 'left'
        }
    },
    {
        type: 'button', typeAttributes: {
            label: 'Del',
            name: 'Del',
            title: 'Del',
            disabled: false,
            value: 'Del',
            iconPosition: 'left'
        }
    }
];

export default class Lwcpj0004invoicelist extends LightningElement {
    //objAPIName = INVOICE_OBJECT;
    //customF = [NAME_FIELD, TAXAMOUNT_FIELD, TAXID_FIELD];
    recordId;
    
    //data;

    @track invoiceList = [];

    // passing a record in
    @track invoiceRecord;

    columns = columns;

    /*
    @wire(deleteCCInvoiceRecords, { invoiceId: '$recordId' })
    wiredInvoices({ error, data }) {
        if (data) {
            this.invoiceList = data;
            this.error = undefined;

        } else if (error) {
            this.error = error;
            this.contacts = undefined;
        }
    }
    */

    // get invoice list

    /*
    @wire(getCCInvoiceRecords)
    invoiceList;
    */


    /*
     @wire(getCCInvoiceRecords)
     wiredAccount({data, error}) {
         //console.log('Execute logic each time a new value is provisioned');
         if (data) {
             this.invoiceList = data;
             this.error = undefined;
         } else if (error) {
             this.error = error;
             this.data = undefined;
         }
     }
     */

    constructor(){
        super();
        this.invoiceRecord;
        getCCInvoiceRecords({})
            .then(result => {
                this.invoiceList = result;
            })
            .catch(error => {
                this.error = error;
            });
    }

    /*
    connectedCallback() {
        this.loadInvoiceRecords();
    }

    loadInvoiceRecords() {
        getCCInvoiceRecords({})
            .then(result => {
                this.invoiceList = result;
            })
            .catch(error => {
                this.error = error;
            });
            //return this.invoiceList;
    }
    */


    getSelectedName(event) {
        const selectedRows = event.detail.selectedRows;
        this.recordId = selectedRows[0].Id;
        alert('----+++++----->' + this.recordId);
    }

    deleteInvoice(){
        deleteCCInvoiceRecords({ invoiceId : this.recordId})
        .then((result) => {
            this.invoiceList = result;
            this.error = undefined;
        })
        .catch((error) => {
            this.error = error;
            this.contacts = undefined;
        });
    }

    // using delete lwc api
    deleteInvoiceRecord(event){
        this.recordId = event.target.value;

        deleteRecord(this.recordId)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record deleted',
                        variant: 'success'
                    })
                );

                
                /*
                let index = this.invoiceList.findIndex(x => x.Id === this.recordId);
                this.invoiceList.splice(index,1);
                */
                    
                
                for(let inv in this.invoiceList){
                    if(this.invoiceList[inv].Id == this.recordId){
                        this.invoiceList.splice(inv,1);
                        break;
                    }
                }
                
                
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        //message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }

    /*
    somethingHappen(event){
        const headActions = event.detail.headeraction;
        alert("some thing happen::");
    }
    */

    /*
    @wire(deleteCCInvoiceRecords,{ invoiceId : '$recordId'})
    invoiceList = [];
    */

    getDeleteRecordId(event) {
        const delRecordId = event.target.value;
        this.recordId = delRecordId;
        //alert('delete? '+this.recordId);
        this.deleteInvoice();
    }



    /*
   getDeleteRecordId(event){
        const delRecordId = event.target.value;
        this.recordId = delRecordId;
   }
   */
}