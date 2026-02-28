@isTest(IsParallel=true)
private class HRZ_CountrySyncServiceTest {
    
    private static final String MOCK_US_COUNTRY_JSON = 
        '{"name":"United States of America","alpha2Code":"US","alpha3Code":"USA","capital":"Washington, D.C.","region":"Americas","altSpellings":["US","USA","United States of America"]}';
    
    private static final String MOCK_ES_COUNTRY_JSON = 
        '{"name":"Spain","alpha2Code":"ES","alpha3Code":"ESP","capital":"Madrid","region":"Europe","altSpellings":["España","Espana"]}';
    
    private static final String MOCK_INVALID_JSON = '{"name":"Invalid","alpha2Code":null}';

    @TestSetup
    static void setup() {
        // No data needed, mocks handle API
    }

    @isTest
    static void fetchCountryDataMultipleCountriesTest() {
        String multiJson = '[' + MOCK_US_COUNTRY_JSON + ',' + MOCK_ES_COUNTRY_JSON + ']';
        Test.setMock(HttpCalloutMock.class, new CountryLayerMock(multiJson));
        
        Test.startTest();
        HRZ_CountrySyncService.fetchCountryData();
        Test.stopTest();
        
        List<HRZ_Country__c> countries = [SELECT HRZ_Alpha2Code__c FROM HRZ_Country__c];
        System.assertEquals(2, countries.size(), 'Debe crear 2 países');
    }

    @isTest
    static void emptyResponseTest() {
        Test.setMock(HttpCalloutMock.class, new CountryLayerMock('[]'));
        
        Test.startTest();
        HRZ_CountrySyncService.fetchCountryData();
        Test.stopTest();
        
        List<HRZ_Country__c> countries = [SELECT Id FROM HRZ_Country__c];
        System.assertEquals(0, countries.size(), 'No debe upsert lista vacía');
    }

    private class CountryLayerMock implements HttpCalloutMock {
        private String mockResponse;
        
        public CountryLayerMock(String response) {
            this.mockResponse = response;
        }
        
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(mockResponse);
            res.setStatusCode(200);
            return res;
        }
    }
}