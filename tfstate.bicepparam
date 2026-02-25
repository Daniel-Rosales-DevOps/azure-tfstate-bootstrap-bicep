// only touch if you change the main bicep file path/name.
using './rg.sub.bicep'

// Location where all resources created by the bootstrap will reside.
param location = 'swedencentral'

// Resource group where all resources created by the bootstrap will reside.
param resourceGroupName = 'tfstate'

// Prefix named used in storage account name, a unique suffix will later be added when deployed. 
param storageAccountPrefix = 'tfstate'

// this will specify the names of the containers used for each environments backend, 'dev-tfstate' and 'prod-tfstate' etc. specify a single env or multiple envs as needed.
param environments = [
  'dev'
  'prod'
]
