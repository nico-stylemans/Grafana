function Get-GrafanaDashboardPermissions{
    <#
    .SYNOPSIS
        Function for list all of Folders / return Folder by ui
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER uid
        Dashboard uid
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$uid
    )
    
    process{
                 
        $url = "/api/dashboards/uid/$uid/permissions"
        
        write-verbose $url
        
        $ReturnValue = Invoke-GrafanaApi -url $url -method "GET" -Auth "Token"

        return $ReturnValue

                
    }
}