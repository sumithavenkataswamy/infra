targetScope = 'resourceGroup'

@minLength(1)
@maxLength(100)
@description('Service Bus namespace name')
param serviceBusNamespaceName string

@minLength(1)
@maxLength(100)
@description('Service Bus Queue Names')
param queueNames array

resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2022-10-01-preview' = {
  name: serviceBusNamespaceName
  location: resourceGroup().location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    zoneRedundant: false
  }
}

resource serviceBusQueue 'Microsoft.ServiceBus/namespaces/queues@2022-10-01-preview' = [
  for queueName in queueNames: {
  parent: serviceBusNamespace
  name: queueName
  properties: {
    requiresSession: false
    defaultMessageTimeToLive: 'P14D'
    deadLetteringOnMessageExpiration: true
    duplicateDetectionHistoryTimeWindow: 'PT10M'
    maxDeliveryCount: 10
  }
}
]
