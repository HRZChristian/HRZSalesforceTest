/**
 * @description Service class responsible for managing and mapping lead country-related operations.
 */
public with sharing class HRZ_LeadCountryMapService {
    /**
     * @description Retrieves geographical and descriptive data for a Lead's associated Country.
     * @param leadId The Id of the Lead record from which to retrieve country data
     * @return Map<String, Object> A map containing coutry data structured for use in a map component
     */
    public static Map<String, Object> getLeadCountryData(Id leadId) {
        Lead lead = HRZ_LeadDAO.getCountryDataByLeadId(leadId);
        
        if (lead.HRZ_Country__c == null) {
            return new Map<String, Object>{'hasCountry' => false};
        }
        
        return new Map<String, Object>{
            'hasCountry' => true,
            'center' => new Map<String, Object>{
                'location' => new Map<String, Object>{
                    'Latitude' => lead.HRZ_Country__r.HRZ_Latitude__c,
                    'Longitude' => lead.HRZ_Country__r.HRZ_Longitude__c
                }
            },
            'markers' => new List<Object>{
                new Map<String, Object>{
                    'location' => new Map<String, Object>{
                        'Latitude' => lead.HRZ_Country__r.HRZ_Latitude__c,
                        'Longitude' => lead.HRZ_Country__r.HRZ_Longitude__c
                    },
                    'title' => lead.HRZ_Country__r.Name + ' (' + lead.HRZ_Country__r.HRZ_Alpha2Code__c + ')',
                    'description' => 'País del Lead: ' + lead.HRZ_Country__r.Name
                }
            },
            'countryName' => lead.HRZ_Country__r.Name
        };
    }
}