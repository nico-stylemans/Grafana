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
        
        Set-GrafanaUrl $url
        Set-GrafanaAuthHeaders -Login $Login -Password $Password -Token $Token
        
        $loginurl = "/api/search"
        
        $ReturnValue = Invoke-GrafanaApi -url $loginurl -method "GET" -Auth "Basic"

        if ($ReturnValue.StatusCode -eq "200"){
            Write-Verbose "Connection succesfull"
        } else {
            Write-Error "Unable to connect : $url"
            Disconnect-Grafana
        }
     
    }
}