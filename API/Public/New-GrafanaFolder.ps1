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
                        
        $url = "/api/folders"
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

        $ReturnValue = Invoke-GrafanaApi -url $url -method "POST" -Auth "Token" -Body $jsonBody

        return $ReturnValue
         
    }
}