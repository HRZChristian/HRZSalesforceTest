@isTest(IsParallel=true)
private class HRZ_LeadCountryMapControllerTest {
    
    @TestSetup
    static void setupTestData() {
        HRZ_Country__c albania = new HRZ_Country__c(
            Name = 'Albania',
            HRZ_Alpha2Code__c = 'AL',
            HRZ_Latitude__c = 41.1533,
            HRZ_Longitude__c = 20.1683
        );
        insert albania;
        
        insert new Lead(LastName = 'SinPais', Company = 'TestCorp');
        
        insert new Lead(
            LastName = 'ConPais', 
            Company = 'TestCorp',
            HRZ_Country__c = albania.Id
        );
    }

    @isTest
    static void getLeadCountryDataWithCountryTest() {
        Lead leadWithCountry = [SELECT Id FROM Lead WHERE LastName = 'ConPais' LIMIT 1];
        
        Test.startTest();
        Map<String, Object> result = HRZ_LeadCountryMapController.getLeadCountryData(leadWithCountry.Id);
        Test.stopTest();
        
        System.assertEquals(true, result.get('hasCountry'), 'Debe tener país');
        
        Map<String, Object> center = (Map<String, Object>) result.get('center');
        Map<String, Object> location = (Map<String, Object>) center.get('location');
        System.assertEquals(41.1533, location.get('Latitude'));
        System.assertEquals(20.1683, location.get('Longitude'));
        
        List<Object> markers = (List<Object>) result.get('markers');
        System.assertEquals(1, markers.size(), '1 marker esperado');
        
        Map<String, Object> marker = (Map<String, Object>) markers[0];
        Map<String, Object> markerLocation = (Map<String, Object>) marker.get('location');
        System.assertEquals('Albania (AL)', marker.get('title'));
        System.assertEquals('País del Lead: Albania', marker.get('description'));
        
        System.assertEquals('Albania', result.get('countryName'));
    }
}
