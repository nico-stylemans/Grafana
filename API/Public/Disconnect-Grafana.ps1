function Disconnect-Grafana{
    <#
    .SYNOPSIS
        Disconnect from Grafana
    .DESCRIPTION

    .EXAMPLE
        Disconnect-Grafana
    #>
    [CmdletBinding()]
    param()
    process{
        $Global:headers = $null
        $Global:grafanaURL = $null

        Write-Verbose "Disconnect successfull"
    }
}