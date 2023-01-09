function Remove-GrafanaTeam{
    <#
    .SYNOPSIS
        Delete Grafana Team
    .DESCRIPTION
        
    .EXAMPLE

    .PARAMETER id
        Team Id
    
    #>
    [CmdletBinding()]
    param(
        
        [Parameter(Mandatory=$true)]
        [string]$id
        
    )
    
    process {
                        
        $url = "/api/teams/$id"
        write-verbose $url
               
        $ReturnValue = Invoke-GrafanaApi -url $url -method "DELETE" -Auth "Basic"

        return $ReturnValue       
    }
}