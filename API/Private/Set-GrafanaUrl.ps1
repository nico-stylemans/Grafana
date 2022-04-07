function Set-GrafanaUrl{
    <#
    .SYNOPSIS
        Set Grafana Url to Global Variable
    .EXAMPLE
        Set-GrafanaUrl -url 
    .PARAMETER url
        Root URL of Grafana
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$url
    )
    process {
        if ( $url -eq $null ) {
            exit 1
        }


        $Global:grafanaURL = $url
    }
}