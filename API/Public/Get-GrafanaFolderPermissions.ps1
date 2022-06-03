function Get-GrafanaFolderPermissions{
    <#
    .SYNOPSIS
        Function for list all of Folders / return Folder by ui
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER uid
        Folder uid
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$uid
    )
    
    process{
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token
         
        $url += "/api/folders/$uid/permissions"
        
        write-verbose $url
    
        # Force using TLS v1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $PermissionList = Invoke-RestMethod -Uri $url -Headers $header -Method GET -ContentType 'application/json;charset=utf-8' -ErrorVariable myerror -StatusCodeVariable mystatus -ResponseHeadersVariable myheaders -SkipHttpErrorCheck
        
        $ReturnValue = New-Object PSObject -Property @{
            StatusCode = $mystatus
            Data = $PermissionList
        }
        return $ReturnValue
    }
}