function Update-GrafanaFolderPermissions{
    <#
    .SYNOPSIS
        Function for list all of Folders / return Folder by ui
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER uid
        Folder uid
    .PARAMETER json
        Json object for permission, wel be converted to json
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$uid,
        [Parameter(Mandatory=$true)]
        [string]$json
    )
    
    process{
                 
        $url = "/api/folders/$uid/permissions"
        
        $jsonBody = ConvertTo-Json -InputObject $json -Depth 100 -Compress  

        write-verbose $url

        $ReturnValue = Invoke-GrafanaApi -url $url -method "POST" -Auth "Token" -Body $jsonBody

        return $ReturnValue
        
    }
}