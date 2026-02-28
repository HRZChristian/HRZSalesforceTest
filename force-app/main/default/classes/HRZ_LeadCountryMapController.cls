/**
 * @description Controller class for managing lead country mapping functionality in the HORIZON Salesforce application.
 */
public with sharing class HRZ_LeadCountryMapController {
    /**
     * @description Retrieves geographical and descriptive data for a Lead's associated Country.
     * @param leadId The Id of the Lead record from which to retrieve country data
     * @return Map<String, Object> A map containing coutry data structured for use in a map component
     */
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getLeadCountryData(Id leadId) {
        return HRZ_LeadCountryMapService.getLeadCountryData(leadId);
    }
}
