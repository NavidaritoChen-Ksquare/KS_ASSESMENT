import { LightningElement, track, wire, api } from 'lwc';
import displayContactRecords  from '@salesforce/apex/ContactController.displayContactRecords';

export default class FrontEndPractice extends LightningElement {
    @api recordId;
    conValue;
    @track conName;
    @track records;
    @track error;
    
    @wire(displayContactRecords,{searchKey:'$conName',accId:'$recordId'})
    wiredContact({error,data}){
        if(data){
            this.records=data;
            this.error=undefined;
        }
        else{
            this.error=error;
            this.records=undefined;
        }
    }

    handleChange(event){
        this.conValue=event.target.value;
        if(event.target.value.length>=3){
            this.conName=event.target.value;
        }
    }
    handleKeyPress(event){
        if(event.keyCode==13){
            this.conName=event.target.value;
        }
    }
    handleClick(event){
        this.conName=this.conValue;
    }
}