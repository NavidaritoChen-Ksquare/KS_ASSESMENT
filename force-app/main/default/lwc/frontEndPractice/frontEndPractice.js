import { LightningElement, track, wire } from 'lwc';
import displayContactRecords  from '@salesforce/apex/ContactController.displayContactRecords';

export default class FrontEndPractice extends LightningElement {
    @track conName;
    @track records;
    @track error;
    @wire(displayContactRecords,{searchKey:'$conName'})
    wiredContact({error,data}){
        if(data){
            this.records=data;
            this.error=undefined;
            console.log(data);
        }
        else{
            this.error=error;
            this.records=undefined;
            console.log('no data');
        }
    }

    handleChange(event){
        this.conName=event.target.value;
        console.log('Contact Name '+this.conName);
    }
}