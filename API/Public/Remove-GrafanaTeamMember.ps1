function Remove-GrafanaTeamMember{
    <#
    .SYNOPSIS
        Remove Member from Team
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER id
        Team id
    .PARAMETER userid
        User id
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$id,
        [Parameter(Mandatory=$true)]
        [string]$userid
    )
    
    process{
        
        $url = "/api/teams/$id/members/$userid"  
               
        write-verbose $url
        
        $ReturnValue = Invoke-GrafanaApi -url $url -method "DELETE" -Auth "Basic"

        return $ReturnValue
        
    }
}