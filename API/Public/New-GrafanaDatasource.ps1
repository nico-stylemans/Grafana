function New-GrafanaDatasource{
    <#
    .SYNOPSIS
        Create New Grafana Datasource
    .DESCRIPTION
        
    .EXAMPLE
        
    .PARAMETER Name
        Datasource Json
    .PARAMETER Uid
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
        Try {
            # Force using TLS v1.2
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            $DsJson = Invoke-RestMethod -Uri $url -Headers $header -Method POST -ContentType 'application/json;charset=utf-8' -Body $jsonBody
            return $DsJson   
        }
        Catch {
            if($_.ErrorDetails.Message) {
                return $_.ErrorDetails.Message
            } else {
                return $_
            }
        }
    }
}