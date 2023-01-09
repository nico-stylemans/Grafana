function Export-GrafanaDashboard{
    <#
    .SYNOPSIS
        Export Json Version of Dashboard
    .DESCRIPTION
        
    .EXAMPLE
        
    .PARAMETER id
        Dashboard id 
    .PARAMETER path
        Path to export to        
    .PARAMETER version
        Dashboard version         
    .PARAMETER latest
        export latest version         
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int]$id,        
        [Parameter(Mandatory=$false)]
        [int]$version,
        [Parameter(Mandatory=$false)]
        [switch]$latest
    )
    
    process {
        
        if ( $latest ){
            $version = (Get-GrafanaDashboardVersion -id $id -latest).Data.version
        }

        $resource = "/api/dashboards/id/$id/versions/$version"
        $url = "$resource"
        write-verbose $url
        
        $ReturnValue = Invoke-GrafanaApi -url $url -method "GET" -Auth "Token"

        return $ReturnValue


    }
}