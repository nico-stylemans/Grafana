function Get-GrafanaDashboard{
    <#
    .SYNOPSIS
        Function for list all of dashboards / return dashboard by ui
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER url
        Grafana root URL
    .PARAMETER uid
        Dashboard uid
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$uid
    )
    
    process{
        
        if ([string]::IsNullOrWhiteSpace($uid)){

            $url = "/api/search?type=dash-db&query=&"  
           
        } 
        else {
            $url = "/api/dashboards/uid/$uid"
            
        }
        write-verbose $url
        
        $ReturnValue = Invoke-GrafanaApi -url $url -method "GET" -Auth "Token"

        return $ReturnValue

        
        
    }
}