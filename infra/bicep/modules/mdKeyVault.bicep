@minLength(3)
@maxLength(24)
param KvName string
param location string
param enablerbac bool

resource keyVault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: KvName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enableRbacAuthorization: enablerbac      // Using Access Policies model
    accessPolicies: []
  }
}

output keyvaulturl string = keyVault.properties.vaultUri
output keyvaultname string = keyVault.name
