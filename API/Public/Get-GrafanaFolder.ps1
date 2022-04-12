function Get-GrafanaFolder{
    <#
    .SYNOPSIS
        Function for list all of Folders / return Folder by ui
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
                $url += "/api/folders"  
            #}
            #else {
            #    $url += "/api/dashboards/id/$id"  
            #    Write-Verbose $url  
            #}
        } 
        else {
            $url += "/api/folders/$uid"
            
        }
        write-verbose $url
        # Force using TLS v1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $FolderList = Invoke-RestMethod -Uri $url -Headers $header -Method GET -ContentType 'application/json;charset=utf-8'
        
        return $FolderList
    }
}