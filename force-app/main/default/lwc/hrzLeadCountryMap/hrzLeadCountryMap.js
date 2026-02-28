import { LightningElement, api, wire } from 'lwc';
import getLeadCountryData from '@salesforce/apex/HRZ_LeadCountryMapController.getLeadCountryData';
import labels from './labels';

export default class HrzLeadCountryMap extends LightningElement {
    @api recordId;
    mapMarkers;
    mapCenter;
    countryName;
    hasCountry = false;
    error;
    labels = labels;

    @wire(getLeadCountryData, { leadId: '$recordId' })
    wiredCountryData({ error, data }) {
        if (data) {
            this.error = undefined;
            this.hasCountry = data.hasCountry;
            if (this.hasCountry) {
                this.mapMarkers = data.markers;
                this.mapCenter = data.center;
                this.countryName = data.countryName;
            }
        } else if (error) {
            this.error = error.body.message;
            console.error('Error mapa: ', error);
        }
    }

    get labels() {
        return labels;
    }
}
