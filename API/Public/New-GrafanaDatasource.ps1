function New-GrafanaDatasource{
    <#
    .SYNOPSIS
        Create New Grafana Datasource
    .DESCRIPTION
        
    .EXAMPLE
        
    .PARAMETER dsjson
        Datasource Json
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        $dsjson            
    )
    
    process {
                    
        $url = "/api/datasources"
        write-verbose $url
                   
        $jsonBody = ConvertTo-Json -InputObject $dsjson -Depth 100 -Compress  
        
        $ReturnValue = Invoke-GrafanaApi -url $url -method "POST" -Auth "Token" -Body $jsonBody

        return $ReturnValue
        
        
    }
}