targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Environment name for naming resources')
param environmentName string

var projectName = 'passport'

var resourceNames = {
  resourceGroupName: 'rg-${projectName}-${environmentName}'
  location:'westeurope'
  appServicePlanName: 'asp-${projectName}-${environmentName}'
  appName: 'app-${projectName}-${environmentName}'
  serviceBusNamespaceName: 'sbns-${environmentName}'
  queueNames: [
    'sbq-${projectName}-${environmentName}-queue1'
  ]
  keyVaultName: 'kv-${projectName}-${environmentName}'
  appConfigName: 'appcs-${projectName}-${environmentName}'
  storageAccountName: 'st-${projectName}-${environmentName}'
}


resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceNames.resourceGroupName
  location: resourceNames.location
}

module appConfig 'appConfig.bicep' = {
  name: 'appConfig'
  scope: rg
  params: {
    appConfigName: resourceNames.appConfigName
  }
}

module keyVault 'keyVault.bicep' = {
  name: 'keyVault'
  scope: rg
  params: {
    keyVaultName: resourceNames.keyVaultName
    appConfigConnectionString: appConfig.outputs.connectionString
  }
  dependsOn: [
    appConfig
  ]
}

module storageAccount 'storageAccount.bicep' = {
  name: 'storageAccount'
  scope: rg
  params: {
    storageAcountName: resourceNames.storageAccountName
  }
}

module appservice 'appService.bicep' = {
  name: 'appService'
  scope: rg
  params: {
    appServicePlanName: resourceNames.appServicePlanName
    webAppName: resourceNames.appName
    location: resourceNames.location
  }
}
