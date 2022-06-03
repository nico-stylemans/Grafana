function Remove-GrafanaFolder{
    <#
    .SYNOPSIS
        Create New Grafana Folder
    .DESCRIPTION
        
    .EXAMPLE
      
    
    .PARAMETER Uid
        Uid of folder
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [String]$Uid   
    )
    
    process {
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token
                
        $url += "/api/folders/$Uid"
        write-verbose $url
        
        
        # Force using TLS v1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $FolderJson = Invoke-RestMethod -Uri $url -Headers $header -Method DELETE -ContentType 'application/json;charset=utf-8' -ErrorVariable myerror -StatusCodeVariable mystatus -ResponseHeadersVariable myheaders -SkipHttpErrorCheck
        
        $ReturnValue = New-Object PSObject -Property @{
            StatusCode = $mystatus
            Data = $FolderJson
        }
        return $ReturnValue
        
    }
}