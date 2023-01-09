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
        #[Parameter(Mandatory=$true)]
        #[String]$Name,        
        #[Parameter(Mandatory=$false)]
        #[String]$Tags,
        [Parameter(Mandatory=$true)]
        $dsjson            
    )  
    
    process {
        
        $url = "/api/dashboards/db"
        write-verbose $url
        #$TagList = $Tags.Split(",")
        
        <# $dashboard = @{ 
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
        } #>
    
        #$jsonBody = ConvertTo-Json -InputObject $body -Depth 100 -Compress  
        
        $jsonBody = ConvertTo-Json -InputObject $dsjson -Depth 100 -Compress  

        $ReturnValue = Invoke-GrafanaApi -url $url -method "POST" -Auth "Token" -Body $jsonBody

        return $ReturnValue

    }
}