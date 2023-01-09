function Update-GrafanaDatasource{
    <#
    .SYNOPSIS
        Create New Grafana Datasource
    .DESCRIPTION
        
    .EXAMPLE
    .PARAMETER id
        Datasournce ID    
    .PARAMETER dsjson
        Datasource Json
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$id,            
        [Parameter(Mandatory=$true)]
        $dsjson            
    )
    
    process {
                        
        $url = "/api/datasources/$id"
        write-verbose $url
                   
        $jsonBody = ConvertTo-Json -InputObject $dsjson -Depth 100 -Compress  

        $ReturnValue = Invoke-GrafanaApi -url $url -method "PUT" -Auth "Token" -Body $jsonBody

        return $ReturnValue

    }
}