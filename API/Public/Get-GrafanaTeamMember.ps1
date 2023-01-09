function Get-GrafanaTeamMember{
    <#
    .SYNOPSIS
        Function for list all of Team Members
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
        
        $url = "/api/teams/$id/members"  
               
        write-verbose $url
                
        $ReturnValue = Invoke-GrafanaApi -url $url -method "GET" -Auth "Basic"

        return $ReturnValue
        
    }
}