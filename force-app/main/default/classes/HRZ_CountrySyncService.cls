public with sharing class HRZ_CountrySyncService {
    
    @InvocableMethod
    public static void fetchCountryData() {
        List<Object> rawCountries = HRZ_CountryLayerClient.fetchAll();
        List<HRZ_Country__c> toUpsert = new List<HRZ_Country__c>();

        for (Object o : rawCountries) {

            Map<String, Object> countryMap = (Map<String, Object>) o;

            String name    = (String) countryMap.get('name');
            String alpha2  = (String) countryMap.get('alpha2Code');
            String alpha3  = (String) countryMap.get('alpha3Code');
            String capital = (String) countryMap.get('capital');
            String region  = (String) countryMap.get('region');
            Object regBlocsObj  = countryMap.get('altSpellings');
            
            if (String.isBlank(alpha2)) {
                continue;
            }
            List<String> regBlocsList = new List<String>();
            if(regBlocsObj != null){         
                List<Object> tempList = (List<Object>) regBlocsObj;

                for (Object reg : tempList) {
                    regBlocsList.add((String) reg);
                }
            }
            String regBlocs = String.join(regBlocsList,',');

            HRZ_Country__c c = new HRZ_Country__c();
            c.Name = name;
            c.HRZ_Alpha2Code__c = alpha2;
            c.HRZ_Alpha3Code__c = alpha3;
            c.HRZ_Capital__c = capital;
            c.HRZ_Region__c = region;
            c.HRZ_Regional_Blocs__c = regBlocs;

            toUpsert.add(c);
        }

        if (!toUpsert.isEmpty()) {
            upsert toUpsert HRZ_Alpha2Code__c;
        }
    }
}