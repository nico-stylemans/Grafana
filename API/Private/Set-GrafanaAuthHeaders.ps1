function Set-GrafanaAuthHeaders{
    <#
    .SYNOPSIS
        
    .DESCRIPTION
        
    .EXAMPLE
        
    .PARAMETER Login
        Login for Grafana authentication
    .PARAMETER Password
        Password for Grafana authentication
    .PARAMETER Token
        API token of Grafana organisation
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$Login,
        [Parameter(Mandatory=$false)]
        [string]$Password,
        [Parameter(Mandatory=$false)]
        [string]$Token
    )

    process {
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $Login,$Password)))
        $headersBasic=@{ 
            Accept = 'application/json'
            Authorization = ("Basic {0}" -f $base64AuthInfo)
        }
        
        $headersToken=@{
            Accept = 'application/json'
            Authorization = "Bearer $token"
        }
        
        $Global:BasicAuth = $headersBasic
        $Global:TokenAuth = $headersToken
    }
}