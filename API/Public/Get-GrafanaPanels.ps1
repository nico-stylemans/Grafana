function Get-GrafanaPanels{
    <#
    .SYNOPSIS
        Function for list all of dashboards / return dashboard by ui
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER uid
        panel uid
    .PARAMETER page
        number of the page to return
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$uid,
        [Parameter(Mandatory=$false)]
        [string]$page
    )
    
    process{
       
        if ([string]::IsNullOrWhiteSpace($uid)){
            $url = "/api/library-elements?kind=1"  
            if ( -not ([string]::IsNullOrWhiteSpace($uid))){  
                $url = "/api/library-elements?kind=1&page=$page"  
            }
        } 
        else {
            $url = "/api/library-elements/$uid"
            
        }
        write-verbose $url
        
        $ReturnValue = Invoke-GrafanaApi -url $url -method "GET" -Auth "Token"

        return $ReturnValue
       
    }
}