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
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token
                
        $url += "/api/datasources"
        write-verbose $url
                   
        $jsonBody = ConvertTo-Json -InputObject $dsjson -Depth 100 -Compress  
        
        # Force using TLS v1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $DsJson = Invoke-RestMethod -Uri $url -Headers $header -Method POST -ContentType 'application/json;charset=utf-8' -Body $jsonBody -ErrorVariable myerror -StatusCodeVariable mystatus -ResponseHeadersVariable myheaders -SkipHttpErrorCheck
        
        $ReturnValue = New-Object PSObject -Property @{
            StatusCode = $mystatus
            Data = $DsJson
        }
        return $ReturnValue
        
    }
}