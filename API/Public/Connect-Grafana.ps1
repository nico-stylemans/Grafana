function Connect-Grafana{
    <#
    .SYNOPSIS
        Function to store Grafana credentials to simplify
        multiples actions
    .DESCRIPTION
        Not realy a connection, just a HTTP header constructor from credential
         or API token
    .EXAMPLE
        Connexion with login / password :       
            Connect-Grafana -authLogin admin -authPassword Passw0rd
        Connexion with Grafana organisation API token
            Connect-Grafana -authToken a1z2e3r4t5y6u7i8o9
    .PARAMETER authLogin
        Login for Grafana authentication
    .PARAMETER authPassword
        Password for Grafana authentication
    .PARAMETER authToken
        API token of Grafana organisation        
    .PARAMETER url
        Grafana root URL
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Login,
        [Parameter(Mandatory=$true)]
        [string]$Password,
        [Parameter(Mandatory=$true)]
        [string]$Token,
        [Parameter(Mandatory=$true)]
        [string]$url
    )
    Process {
        #$Global:grafanaURL = Set-Grafana-Url -url $url
        Set-GrafanaUrl $url
        Set-GrafanaAuthHeaders -Login $Login -Password $Password -Token $Token
        #$Global:headers = Set-Grafana-Auth-Header -authLogin $Login -authPassword $Password `
        #                                            -authToken $Token   

        $url += "/api/search"
        #$resource = "/api/search"
        #$param = "?type=dash-db&query="
        #$url += "$resource/$param"

        # Test connection to validate credential
        # Force using TLS v1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $header = Get-AuthHeader -Type Basic
        try{
            Invoke-RestMethod -Uri $url -Method Get -ContentType 'application/json;charset=utf-8' -Headers $header | Out-null
            Write-Verbose "Connexion succesfull"
        }catch{
            Write-Error "Unable to connect : $_"
            Disconnect-Grafana
        }
    }
}