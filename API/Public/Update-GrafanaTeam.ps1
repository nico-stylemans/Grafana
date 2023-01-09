function Update-GrafanaTeam{
    <#
    .SYNOPSIS
        Update Grafana Team
    .DESCRIPTION
        
    .EXAMPLE

    .PARAMETER id
        Team Id
    .PARAMETER json
        Json file
    
    #>
    [CmdletBinding()]
    param(
        
        [Parameter(Mandatory=$true)]
        [string]$id,
        [Parameter(Mandatory=$true)]
            $teamjson            
        
    )
    
    process {
                        
        $url = "/api/teams/$id"
        write-verbose $url
               
        $jsonBody = ConvertTo-Json -InputObject $teamjson -Depth 100 -Compress  

        $ReturnValue = Invoke-GrafanaApi -url $url -method "PUT" -Body $jsonBody -Auth "Basic"
        return $ReturnValue       
    }
}