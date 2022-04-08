function New-GrafanaDashboard{
    <#
    .SYNOPSIS
        Create New Grafana Dashboard
    .DESCRIPTION
        
    .EXAMPLE
        
    .PARAMETER Name
        Dashboard Name
    .PARAMETER Tags
        Comma seperated Tags List
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [String]$Name,        
        [Parameter(Mandatory=$false)]
        [String]$Tags   
    )
    
    process {
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token
                
        $url += "/api/dashboards/db"
        write-verbose $url
        $TagList = $Tags.Split(",")
        
        $dashboard = @{ 
            id = $null
            uid = $null
            title = $name
            tags = $TagList
            timezone = "browser"
            schemaVersion = 16
            version = 0
        }

        $body = @{
            dashboard = $dashboard
            inputs = @()
            folderId = 0
            overwrite = $false
        }
    
        $jsonBody = ConvertTo-Json -InputObject $body -Depth 100 -Compress  

        # Force using TLS v1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $dashboardJson = Invoke-RestMethod -Uri $url -Headers $header -Method POST -ContentType 'application/json;charset=utf-8' -Body $jsonBody
        return $dashboardJson   
    }
}