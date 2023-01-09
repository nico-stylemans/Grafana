function Get-GrafanaTeam{
    <#
    .SYNOPSIS
        Function for list all of Teams
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER id
        Team id
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$id
    )
    
    process{
        
        if ([string]::IsNullOrWhiteSpace($id)){

           $url = "/api/teams/search?"  
        
        } 
        else {
            $url = "/api/teams/$id"
            
        }
        write-verbose $url
                
        $ReturnValue = Invoke-GrafanaApi -url $url -method "GET" -Auth "Basic"

        return $ReturnValue
        
    }
}