function New-GrafanaFolder{
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
        [Parameter(Mandatory=$false)]
        [String]$Uid   
    )
    
    process {
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token
                
        $url += "/api/folders"
        write-verbose $url
        
        if ([string]::IsNullOrWhiteSpace($Uid)){
            $folderuid = $null
        }
        else {
            $folderuid = $Uid
        }

        $Folder = @{ 
            uid = $folderuid
            title = $name
        }
           
        $jsonBody = ConvertTo-Json -InputObject $folder -Depth 100 -Compress  

        
        # Force using TLS v1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $FolderJson = Invoke-RestMethod -Uri $url -Headers $header -Method POST -ContentType 'application/json;charset=utf-8' -Body $jsonBody -ErrorVariable myerror -StatusCodeVariable mystatus -ResponseHeadersVariable myheaders -SkipHttpErrorCheck
        
        $ReturnValue = New-Object PSObject -Property @{
            StatusCode = $mystatus
            Data = $FolderJson
        }
        return $ReturnValue
         
    }
}