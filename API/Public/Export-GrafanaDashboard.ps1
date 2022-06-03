function Export-GrafanaDashboard{
    <#
    .SYNOPSIS
        Export Json Version of Dashboard
    .DESCRIPTION
        
    .EXAMPLE
        
    .PARAMETER id
        Dashboard id 
    .PARAMETER path
        Path to export to        
    .PARAMETER version
        Dashboard version         
    .PARAMETER latest
        export latest version         
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int]$id,        
        [Parameter(Mandatory=$false)]
        [int]$version,
        [Parameter(Mandatory=$false)]
        [switch]$latest
    )
    
    process {
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token
        
        if ( $latest ){
            $version = (Get-GrafanaDashboardVersion -id $id -latest).Data.version
        }

        $resource = "/api/dashboards/id/$id/versions/$version"
        $url += "$resource"
        write-verbose $url
        
        # Force using TLS v1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $dashboardJson = Invoke-RestMethod -Uri $url -Headers $header -Method GET -ContentType 'application/json;charset=utf-8' -ErrorVariable myerror -StatusCodeVariable mystatus -ResponseHeadersVariable myheaders -SkipHttpErrorCheck
        #$json = ConvertTo-Json $dashboardJson.data -depth 100 -compress
        $ReturnValue = New-Object PSObject -Property @{
            StatusCode = $mystatus
            Data = $dashboardJson.data
        }
        return $ReturnValue
    }
}