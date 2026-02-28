public without sharing class HRZ_CountryLayerClient implements Database.AllowsCallouts {
    
    public static List<Object> fetchAll() {
        HRZ_CountryLayerSettings__mdt countryLayerMeta = HRZ_CountryLayerSettings__mdt.getInstance('HRZ_CountryLayer');
        System.debug('countryLayerMeta: ' + countryLayerMeta);
        if (String.isBlank(countryLayerMeta.HRZ_AccessKey__c) || String.isBlank(countryLayerMeta.HRZ_EndpointPath__c)) {
            throw new HRZ_CountryLayerException('Missing HRZ CountryLayer settings.');
        }

        HttpRequest req = new HttpRequest();
        req.setMethod('GET');

        String endpoint = 'callout:HRZ_Country_Layer' + countryLayerMeta.HRZ_EndpointPath__c
            + '?access_key=' + EncodingUtil.urlEncode(countryLayerMeta.HRZ_AccessKey__c, 'UTF-8');

        req.setEndpoint(endpoint);
        System.debug('endpoint: ' + endpoint);

        HttpResponse res = new Http().send(req);
        Integer code = res.getStatusCode();
        if (code < 200 || code >= 300) {
            throw new HRZ_CountryLayerException('CountryLayer error: ' + code + ' - ' + res.getBody());
        }

        Object countriesInfo = JSON.deserializeUntyped(res.getBody());
                System.debug('countriesInfo: ' + countriesInfo);

        return (List<Object>) countriesInfo;
    }
    
        public class HRZ_CountryLayerException extends Exception {}
}