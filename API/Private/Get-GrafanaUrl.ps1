function Get-GrafanaUrl{
    <#
    .SYNOPSIS
        Return Grafana Url from Global Variable
    .EXAMPLE
        Get-GrafanaUrl
    #>
    
    [CmdletBinding()]
    param()
    process {
        $url = $Global:grafanaURL
        
        return $url
    }
}