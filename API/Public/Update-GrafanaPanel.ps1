function Update-GrafanaPanel{
    <#
    .SYNOPSIS
        Create New Grafana Panel
    .DESCRIPTION
        
    .EXAMPLE
        
    .PARAMETER name
        name of the panel
    .PARAMETER model
        Panel Json Mdoel
    .PARAMETER folderid
        FolderId to save panel
    .PARAMETER version
        version of panel to update
    .PARAMETER uid
        Unique ID of the panel
    
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [String]$name,
        [Parameter(Mandatory=$true)]
        [String]$model,        
        [Parameter(Mandatory=$true)]
        [String]$folderid,
        [Parameter(Mandatory=$true)]
        [String]$version,
        [Parameter(Mandatory=$false)]
        [String]$uid
    )
    
    process {
        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token
                
        $url += "/api/library-elements"
        write-verbose $url

        if ([string]::IsNullOrWhiteSpace($uid)){
            $uid = $null
        }
        if ([string]::IsNullOrWhiteSpace($folderid)){
            $folderid = 0
        }
        
        $body = @{
            uid = $uid
            folderId = $folderid
            name = $name
            model = $model
            kind = 1
            version = $version
        }
    
        $jsonBody = ConvertTo-Json -InputObject $body -Depth 100 -Compress  

        try {
            # Force using TLS v1.2
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
            $panelJson = Invoke-RestMethod -Uri $url -Headers $header -Method PATCH -ContentType 'application/json;charset=utf-8' -Body $jsonBody
            return $panelJson   
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