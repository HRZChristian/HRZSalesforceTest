# 🗺️ HRZ Lead Country Assignment & Mapping

[![Salesforce](https://img.shields.io/badge/Salesforce-60.0-blue.svg)](https://developer.salesforce.com/)
[![Apex](https://img.shields.io/badge/Apex-100%25_Coverage-brightgreen.svg)](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/)
[![LWC](https://img.shields.io/badge/LWC-Map_Component-orange.svg)](https://developer.salesforce.com/docs/component-library/)

**Proyecto Salesforce completo** que sincroniza datos de países desde **CountryLayer API**, valida Leads antes de reasignación de Owner y muestra **mapas interactivos** del país del Lead usando `lightning-map` nativo.

## 🏗️ Arquitectura del Sistema

```mermaid
graph TD
    A[CountryLayer API] --> B[HRZ_CountryLayerClient]
    B --> C[HRZ_CountrySyncService]
    C --> D[HRZ_Country__c Object]
    
    D --> E[Lead.HRZ_Country__c Lookup]
    E --> F[Validation Rule]
    E --> G[Owner Flow Owner_Since__c]
    
    E --> H[hrzLeadCountryMap LWC]
    H --> I[lightning-map Native]
