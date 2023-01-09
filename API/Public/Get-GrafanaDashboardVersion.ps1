function Get-GrafanaDashboardVersion{
    <#
    .SYNOPSIS
        List versions of a Dashboard
    .DESCRIPTION
        
    .EXAMPLE
        
    .PARAMETER id
        Dashboard id
    .PARAMETER lastest
        return only the latest version
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [int]$id,
        [Parameter(Mandatory=$false)]
        [switch]$latest
    )
    process{
        
        $resource = "/api/dashboards/id/$id/versions"
        $url = "$resource"
        
        if ( $latest -eq $true ){
            $param = "?limit=1"
            $url += $param
        }
        write-verbose $url
        
        $ReturnValue = Invoke-GrafanaApi -url $url -method "GET" -Auth "Token"

        return $ReturnValue
        
        
    }
}