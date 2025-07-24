@minLength(1)
@maxLength(100)
@description('App configuration that can be used as part of naming resource convention')
param appConfigName string

resource appConfig 'Microsoft.AppConfiguration/configurationStores@2024-06-01' = {
  name: appConfigName
  location: resourceGroup().location
  sku: {
    name: 'Standard'
  }
}
output connectionString string = listKeys(appConfig.id, appConfig.apiVersion).primaryConnectionString
