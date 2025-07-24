targetScope = 'resourceGroup'

@minLength(1)
@maxLength(100)
@description('Key Vault name')
param keyVaultName string

@description('App Configuration connection string to store as secret')
param appConfigConnectionString string

var secrets = [
  {
    AppConfigConnectionString: appConfigConnectionString
  }
] 

resource keyVault 'Microsoft.KeyVault/vaults@2024-11-01' = {
  name: keyVaultName
  location: resourceGroup().location
  properties: {
    enableRbacAuthorization: true
    enableSoftDelete: true
    enablePurgeProtection: true
    tenantId: subscription().tenantId
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}

resource keyVaultSecrets 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = [for secret in secrets: {
  parent: keyVault
  name: secret.AppConfigConnectionString
  properties: {
    value: secret.AppConfigConnectionString
  }
}]
