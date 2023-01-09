function Get-GrafanaFolder{
    <#
    .SYNOPSIS
        Function for list all of Folders / return Folder by ui
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER uid
        Dashboard uid
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$uid
    )
    
    process{
        
        if ([string]::IsNullOrWhiteSpace($uid)){

            $url = "/api/folders"  
         
        } 
        else {
            $url = "/api/folders/$uid"
            
        }
        write-verbose $url
           
        $ReturnValue = Invoke-GrafanaApi -url $url -method "GET" -Auth "Token"

        return $ReturnValue
        
    }
}