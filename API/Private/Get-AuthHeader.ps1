function Get-AuthHeader{
    <#
    .SYNOPSIS
        Return AuthenticationHeader from Global Variable
    .EXAMPLE
        Get-AuthHeader -Type Basic
    #>
    
    [CmdletBinding()]
    param([Parameter(Mandatory=$false)]
          [string]$Type
    )
    process {
        if ($Type -eq "Basic") {
            $header = $Global:BasicAuth
        }
        else {
            $header = $Global:TokenAuth
        }
        return $header
    }
}