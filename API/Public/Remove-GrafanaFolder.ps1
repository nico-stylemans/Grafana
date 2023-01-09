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
                        
        $url = "/api/folders/$Uid"
        write-verbose $url
        
        $ReturnValue = Invoke-GrafanaApi -url $url -method "DELETE" -Auth "Token"

        return $ReturnValue
        
    }
}