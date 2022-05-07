param acccesspolicies array
param keyVault string
param apaction string



resource symbolicname 'Microsoft.KeyVault/vaults/accessPolicies@2021-10-01' = {
  name: '${keyVault}/${apaction}' // add replace remove
  properties: {
    accessPolicies: [ for ap in acccesspolicies: {
        applicationId: ap.appid
        objectId: ap.objid
        tenantId: ap.tentatid
        permissions: ap.permissions
      }]
  }
}
