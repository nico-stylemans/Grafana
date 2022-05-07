param KeyvName string
param keylocation string
param secrets array
param policyaction string
param enablerbac bool
param aplist array

 module Keyvault 'Modules/mdKeyVault.bicep' = {
   name : 'KeyVaultDeploy'
   params : {
     KvName : KeyvName
     location : keylocation   
     enablerbac: enablerbac
   }
 }

module KeyvaultPolicies 'Modules/mdKeyVaultaccessPolicies.bicep' = if (!enablerbac) {
  name : 'KeyVaulPoliciesDeploy'
  params : {
    apaction : policyaction
    acccesspolicies : aplist
    keyVault : Keyvault.outputs.keyvaultname   
  }
}

module KeyvaultSecret 'Modules/mdKeyVaultSecret.bicep' = [ for secret in secrets :{
  name : '${secret.scname}Deploy'
  params : {
    secretname : secret.scname
    secretvalue : secret.scvalue 
    keyVault : Keyvault.outputs.keyvaultname   
  }
}]
