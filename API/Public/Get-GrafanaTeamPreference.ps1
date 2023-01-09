function Get-GrafanaTeamPreference{
    <#
    .SYNOPSIS
        Get Team Preferences
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER id
        Team id
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$id
    )
    
    process{
        
        $url = "/api/teams/$id/preferences"  
               
        write-verbose $url
                
        $ReturnValue = Invoke-GrafanaApi -url $url -method "GET" -Auth "Token"

        return $ReturnValue
        
    }
}