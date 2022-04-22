function Get-GrafanaDashboardPermissions{
    <#
    .SYNOPSIS
        Function for list all of Folders / return Folder by ui
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER uid
        Dashboard uid
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$uid
    )
    
    process{
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token
         
        $url += "/api/dashboards/uid/$uid/permissions"
        
        write-verbose $url
        try {
        # Force using TLS v1.2
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            $PermissionList = Invoke-RestMethod -Uri $url -Headers $header -Method GET -ContentType 'application/json;charset=utf-8'
            
            return $PermissionList
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