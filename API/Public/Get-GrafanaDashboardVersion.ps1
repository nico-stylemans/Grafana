function Get-GrafanaDashboardVersion{
    <#
    .SYNOPSIS
        List versions of a Dashboard
    .DESCRIPTION
        
    .EXAMPLE
        
    .PARAMETER id
        Dashboard id
    .PARAMETER lastest
        return only the latest version
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [int]$id,
        [Parameter(Mandatory=$false)]
        [switch]$latest
    )
    process{
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token

        $resource = "/api/dashboards/id/$id/versions"
        $url += "$resource"
        
        if ( $latest -eq $true ){
            $param = "?limit=1"
            $url += $param
        }
        write-verbose $url
        # Force using TLS v1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $dashboardVersions = Invoke-RestMethod -Uri $url -Headers $header -Method GET -ContentType 'application/json;charset=utf-8'
        
        return $dashboardVersions
    }
}