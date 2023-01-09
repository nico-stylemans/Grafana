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
                        
        $url = "/api/folders/$Uid"
        write-verbose $url
        
        
        $Folder = @{ 
            uid = $Uid
            title = $name
            overwrite = $true
        }
           
        $jsonBody = ConvertTo-Json -InputObject $folder -Depth 100 -Compress  

        $ReturnValue = Invoke-GrafanaApi -url $url -method "PUT" -Auth "Token" -Body $jsonBody

        return $ReturnValue

    }
}