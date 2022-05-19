param KeyvName string
param keylocation string
param secrets array
param policyaction string

param enablerbac bool
param aplist array
param addsecrets bool


resource keyVault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: KeyvName
  location: keylocation
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

resource symbolicname 'Microsoft.KeyVault/vaults/accessPolicies@2021-10-01' = if (!enablerbac) {
  name: policyaction // add replace remove
  parent: keyVault
  properties: {
    accessPolicies: [ for ap in aplist: {
        applicationId: ap.appid
        objectId: ap.objid
        tenantId: ap.tentatid
        permissions: ap.permissions
      }]
  }
}

resource secret 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = [ for secret in secrets : if (addsecrets){
  name: secret.scname
  parent: keyVault
  properties: {
    value: secret.scvalue
  }
}]
