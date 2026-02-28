/**
 * @description Data Access Object (DAO) class for Lead records.
 */
public with sharing class HRZ_LeadDAO {

    /**
     * @description Retrieves country geographical and identification data for a specific Lead record.
     * @param leadId The Id of the Lead record to retrieve country data for
     * @return Lead object containing HRZ_Country__r fields with geographical and identification data
     */
    public static Lead getCountryDataByLeadId(Id leadId) {
        return [
            SELECT HRZ_Country__r.HRZ_Latitude__c, HRZ_Country__r.HRZ_Longitude__c, 
                HRZ_Country__r.Name, HRZ_Country__r.HRZ_Alpha2Code__c 
                FROM Lead WHERE Id = :leadId LIMIT 1
            ];
    }
}