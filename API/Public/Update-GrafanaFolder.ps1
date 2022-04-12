function Update-GrafanaFolder{
    <#
    .SYNOPSIS
        Create New Grafana Folder
    .DESCRIPTION
        
    .EXAMPLE
        
    .PARAMETER Name
        FolderName Name
    .PARAMETER Uid
        Uid
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [String]$Name,        
        [Parameter(Mandatory=$true)]
        [String]$Uid   
    )
    
    process {
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token
                
        $url += "/api/folders/$Uid"
        write-verbose $url
        
        
        $Folder = @{ 
            uid = $Uid
            title = $name
            overwrite = $true
        }
           
        $jsonBody = ConvertTo-Json -InputObject $folder -Depth 100 -Compress  

        # Force using TLS v1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $FolderJson = Invoke-RestMethod -Uri $url -Headers $header -Method PUT -ContentType 'application/json;charset=utf-8' -Body $jsonBody
        return $FolderJson   
    }
}