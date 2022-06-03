function Update-GrafanaFolderPermissions{
    <#
    .SYNOPSIS
        Function for list all of Folders / return Folder by ui
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER uid
        Folder uid
    .PARAMETER json
        Json object for permission, wel be converted to json
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$uid,
        [Parameter(Mandatory=$true)]
        [string]$json
    )
    
    process{
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token
         
        $url += "/api/folders/$uid/permissions"
        
        $jsonBody = ConvertTo-Json -InputObject $json -Depth 100 -Compress  

        write-verbose $url
        
        # Force using TLS v1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $PermissionList = Invoke-RestMethod -Uri $url -Headers $header -Method POST -ContentType 'application/json;charset=utf-8' -Body $jsonBody -ErrorVariable myerror -StatusCodeVariable mystatus -ResponseHeadersVariable myheaders -SkipHttpErrorCheck
        
        $ReturnValue = New-Object PSObject -Property @{
            StatusCode = $mystatus
            Data = $PermissionList
        }

        return $ReturnValue
    }
}