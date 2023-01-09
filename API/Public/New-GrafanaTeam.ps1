function New-GrafanaTeam{
    <#
    .SYNOPSIS
        Create New Grafana Team
    .DESCRIPTION
        
    .EXAMPLE
        
    .PARAMETER json
        Json file
    
    #>
    [CmdletBinding()]
    param(
        
        [Parameter(Mandatory=$true)]
            $teamjson            
        
    )
    
    process {
                        
        $url = "/api/teams"
        write-verbose $url
               
        $jsonBody = ConvertTo-Json -InputObject $teamjson -Depth 100 -Compress  

        $ReturnValue = Invoke-GrafanaApi -url $url -method "POST" -Body $jsonBody -Auth "Basic"
        return $ReturnValue       
    }
}