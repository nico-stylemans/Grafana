function Invoke-GrafanaApi{

    <#
    .SYNOPSIS
        Invoke Grafana API Calls
    .EXAMPLE
        
    .PARAMETER url
        Root URL of Grafana
    #>
    param(
        [Parameter(Mandatory=$true)]
        [string]$url,
        [Parameter(Mandatory=$true)]
        [ValidateSet("GET", "POST", "PUT", "DELETE", "PATCH")]
        [string]$method,
        [ValidateSet("Basic", "Token")]
        [string]$Auth,
        [Parameter(Mandatory=$false)]
        $body
    )
    process {

        $grafurl = Get-GrafanaUrl
        $header = Get-AuthHeader -Type $Auth
        
        # Add api url to base url
        $grafurl += $url

        # Force using TLS v1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        
        if ($method -in 'GET', 'DELETE') {
            $Return = Invoke-RestMethod -Uri $grafurl -Headers $header -Method $method -ContentType 'application/json;charset=utf-8' -ErrorVariable myerror -StatusCodeVariable mystatus -ResponseHeadersVariable myheaders -SkipHttpErrorCheck
        }
        else {
            $Return = Invoke-RestMethod -Uri $grafurl -Headers $header -Method $method -Body $body -ContentType 'application/json;charset=utf-8' -ErrorVariable myerror -StatusCodeVariable mystatus -ResponseHeadersVariable myheaders -SkipHttpErrorCheck
        }
    
        $ReturnValue = New-Object PSObject -Property @{
            StatusCode = $mystatus
            Data = $Return
        }
        
        return $ReturnValue
    }

}