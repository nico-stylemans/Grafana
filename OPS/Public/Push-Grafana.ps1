function Push-Grafana{
    <#
    .SYNOPSIS
        Function Push Grafana config from json
    .DESCRIPTION
        
    .EXAMPLE
            Push-Grafana -Login admin -Password Passw0rd -Token fsqjdfmlj -url http://localhost:3000
    .PARAMETER Login
        Login for Grafana authentication
    .PARAMETER Password
        Password for Grafana authentication
    .PARAMETER Token
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
        [string]$url,
        [Parameter(Mandatory=$true)]
        [string]$path
    )
    Process {
        
    }
}