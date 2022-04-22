function Get-GrafanaDashboard{
    <#
    .SYNOPSIS
        Function for list all of dashboards / return dashboard by ui
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER url
        Grafana root URL
    .PARAMETER uid
        Dashboard uid
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$uid
        #[Parameter(Mandatory=$false)]
        #[string]$id
    )
    
    process{
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token

        if ([string]::IsNullOrWhiteSpace($uid)){

            #if ([string]::IsNullOrWhiteSpace($id)){
                $url += "/api/search?type=dash-db&query=&"  
            #}
            #else {
            #    $url += "/api/dashboards/id/$id"  
            #    Write-Verbose $url  
            #}
        } 
        else {
            $url += "/api/dashboards/uid/$uid"
            
        }
        write-verbose $url
        try {
            # Force using TLS v1.2
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            $dashboardList = Invoke-RestMethod -Uri $url -Headers $header -Method GET -ContentType 'application/json;charset=utf-8'
            
            return $dashboardList
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