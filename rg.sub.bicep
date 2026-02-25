targetScope = 'subscription' // RG creation requires this.

param location string
param resourceGroupName string
param storageAccountPrefix string
param environments array

// Deterministic => no duplicates on rerun
var storageAccountName = toLower('${storageAccountPrefix}${uniqueString(subscription().id, resourceGroupName)}')

resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: location
}

module tfstate './tfStorage.rg.bicep' = {
  name: 'tfstateRgResources'
  scope: rg
  params: {
    location: location
    storageAccountName: storageAccountName
    environments: environments
  }
}
