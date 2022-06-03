function Get-GrafanaDatasource{
    <#
    .SYNOPSIS
        Function for list all or specific datasource from organization.
    .DESCRIPTION
        

    .EXAMPLE
      
    
    .PARAMETER name
        Name of datasource to get
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$name,
        [Parameter(Mandatory=$false)]
        [string]$id,
        [Parameter(Mandatory=$false)]
        [string]$uid
    )
    
    process {
        $name = $name -replace " ","%20"

        $url = Get-GrafanaUrl
        $header = Get-AuthHeader -Type token

        $url += "/api/datasources"

        if ([string]::IsNullOrWhiteSpace($id)){
            if ([string]::IsNullOrWhiteSpace($uid)) {
                if ([string]::IsNullOrWhiteSpace($name)){
                    
                }
                else {
                    $name = $name -replace " ","%20"
                    $url += "/name/$name"    
                    
                }
            }
            else {
                $url += "/uid/$uid" 
                
            }
        } 
        else {
            $url += "/$id"
            
        }
        write-verbose $url
        
        # Force using TLS v1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $DataSourceList = Invoke-RestMethod -Uri $url -Headers $header -Method GET -ContentType 'application/json;charset=utf-8' -ErrorVariable myerror -StatusCodeVariable mystatus -ResponseHeadersVariable myheaders -SkipHttpErrorCheck

        $ReturnValue = New-Object PSObject -Property @{
            StatusCode = $mystatus
            Data = $DataSourceList
        }

        return $ReturnValue
    
    }
}