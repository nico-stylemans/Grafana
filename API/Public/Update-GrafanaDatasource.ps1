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
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token
                
        $url += "/api/datasources/$id"
        write-verbose $url
                   
        $jsonBody = ConvertTo-Json -InputObject $dsjson -Depth 100 -Compress  

        try {
            # Force using TLS v1.2
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            $DsJson = Invoke-RestMethod -Uri $url -Headers $header -Method PUT -ContentType 'application/json;charset=utf-8' -Body $jsonBody
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