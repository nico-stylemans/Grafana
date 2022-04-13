function Get-GrafanaSettings{
    <#
    .SYNOPSIS
        Function for listing all Settings in ini file
    .DESCRIPTION

    .EXAMPLE
        
    
    #>
    [CmdletBinding()]
    param(
    
    )
    
    process{
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type Basic

        $url += "/api/admin/settings"  
        
        write-verbose $url
        # Force using TLS v1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $Settings = Invoke-RestMethod -Uri $url -Headers $header -Method GET -ContentType 'application/json;charset=utf-8'
        
        return $Settings
    }
}