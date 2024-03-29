function Get-GrafanaSettings{
    <#
    .SYNOPSIS
        Function for listing all Settings in ini file
    .DESCRIPTION

    .EXAMPLE
        
    
    #>
    [CmdletBinding()]
    param(
    
    )
    
    process{
        
        $url = "/api/admin/settings"  
        
        write-verbose $url
        
        $ReturnValue = Invoke-GrafanaApi -url $url -method "GET" -Auth "Basic"

        return $ReturnValue

    }
}