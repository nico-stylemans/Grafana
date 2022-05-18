subid         = "<your subscription ID>"
clientid      = "<your client ID>"
client_secret = "<your client secret>"
tenantid     = "<your tentant id"

KvName        = "<your keyvaultname>"
location      = "westeurope"
rg            = "<your resourcegroup>"
enablerbac    = false

accesspolicies =  {

    pol0 = {
        appid                      = null
        objid                      = "<your SP objid>"
        tenantid                   = "<tenantid>"
        certperm                   = null
        keyperm                    = null
        secperm                    = ["Get", "List", "Delete", "Backup", "Purge", "Recover", "Restore", "Set"]
        stoperm                    = null
      },
    pol1 = {
        appid                      = null
        objid                      = "<Optional Access obj>"
        tenantid                   = "<tentatid>"
        certperm                   = ["Get", "List", "Delete"]
        keyperm                    = ["Get", "List", "Delete"]
        secperm                    = ["Get", "List"]
        stoperm                    = ["Get", "List", "Delete"]
      },
    pol2 = {
        appid                      = null
        objid                      = "<Optional Access obj>"
        tenantid                   = "<tenatid>"
        certperm                   = ["Get", "List", "Delete"]
        keyperm                    = ["Get", "List", "Delete"]
        secperm                    = ["Get", "List", "Delete", "Backup", "Purge", "Recover", "Restore", "Set"]
        stoperm                    = ["Get", "List", "Delete"]
      }
  }

Secrets = {

    sc1 = {
        scname                      = "secret1"
        scvalue                     = "xxxxxx"
      },
    sc2 = {
        scname                      = "secret2"
        scvalue                     = "xxx"
      },
	  sc3 = {
        scname                      = "secret3"
        scvalue                     = "xxx"
      }
  }





