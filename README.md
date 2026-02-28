# 🗺️ HRZ Lead Country Assignment & Mapping

[![Salesforce](https://img.shields.io/badge/Salesforce-60.0-blue.svg)](https://developer.salesforce.com/)
[![Apex](https://img.shields.io/badge/Apex-100%25_Coverage-brightgreen.svg)](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/)
[![LWC](https://img.shields.io/badge/LWC-Map_Component-orange.svg)](https://developer.salesforce.com/docs/component-library/)

**Proyecto Salesforce completo** que sincroniza datos de países desde **CountryLayer API**, valida Leads antes de reasignación de Owner y muestra **mapas interactivos** del país del Lead usando `lightning-map` nativo.

## ✨ Características Principales

| Componente | Descripción | Status |
|------------|-------------|--------|
| **HRZ_CountryLayerClient** | Cliente HTTP seguro para API CountryLayer (`/v2/all`) | ✅ **Producción** |
| **HRZ_CountrySyncService** | `@InvocableMethod` sincroniza ~250 países → `HRZ_Country__c` | ✅ **95%+ Coverage** |
| **Lead Validation Rule** | Bloquea reasignación sin País/Fuente/Empleados *(excepto Admins)* | ✅ **Activa** |
| **Owner Assignment Flow** | Timestamp automático `Owner_Since__c` en cambios | ✅ **Automático** |
| **hrzLeadCountryMap LWC** | Mapa nativo con marker/popup del país del Lead | ✅ **Record Page** |
| **HRZ_LeadCountryMapController** | `@AuraEnabled(cacheable)` retorna datos geo JSON | ✅ **95%+ Coverage** |

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
