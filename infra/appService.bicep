targetScope = 'resourceGroup'

@minLength(1)
@description('Name of the App Service Plan')
param appServicePlanName string

@minLength(1)
@description('Name of the App Service (Web App)')
param webAppName string

@minLength(1)
@description('Location for resources')
param location string = resourceGroup().location

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    capacity: 1
  }
  properties: {
    reserved: false
  }
}

resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      netFrameworkVersion: 'v8.0'
    }
  }
  dependsOn: [
    appServicePlan
  ]
}
