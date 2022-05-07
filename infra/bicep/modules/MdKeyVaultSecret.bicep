param secretname string
param keyVault string
param secretvalue string

resource secret 'Microsoft.KeyVault/vaults/secrets@2019-09-01' = {
  name: '${keyVault}/${secretname}'
  properties: {
    value: secretvalue
  }
}

output secreturl string = secret.properties.secretUri


