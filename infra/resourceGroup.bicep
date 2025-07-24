targetScope = 'subscription'

@minLength(1)
@maxLength(100)
@description('Name of the resource group to create')
param resourceGroupName string

@minLength(1)
@maxLength(100)
@description('Location for the resource group')
param location string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: location
}
