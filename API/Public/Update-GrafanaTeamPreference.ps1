function Update-GrafanaTeamPreference{
    <#
    .SYNOPSIS
        Get Team Preferences
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER id
        Team id
    .PARAMETER json
        Team preferences json
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$id,
        [Parameter(Mandatory=$true)]
        [string]$json    
    )
    
    process{
        
        $url = "/api/teams/$id/preferences"  
               
        write-verbose $url
                
        $ReturnValue = Invoke-GrafanaApi -url $url -method "PUT" -Auth "Token" -Body $json

        return $ReturnValue
        
    }
}