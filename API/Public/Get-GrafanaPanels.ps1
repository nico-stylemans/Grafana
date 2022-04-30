function Get-GrafanaPanels{
    <#
    .SYNOPSIS
        Function for list all of dashboards / return dashboard by ui
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER uid
        panel uid
    .PARAMETER page
        number of the page to return
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$uid,
        [Parameter(Mandatory=$false)]
        [string]$page
    )
    
    process{
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token

        if ([string]::IsNullOrWhiteSpace($uid)){
            $url += "/api/library-elements?kind=1"  
            if ( -not ([string]::IsNullOrWhiteSpace($uid))){  
                $url += "/api/library-elements?kind=1&page=$page"  
            }
        } 
        else {
            $url += "/api/library-elements/$uid"
            
        }
        write-verbose $url
        try {
            # Force using TLS v1.2
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            $panelList = Invoke-RestMethod -Uri $url -Headers $header -Method GET -ContentType 'application/json;charset=utf-8'
            
            return $panelList
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