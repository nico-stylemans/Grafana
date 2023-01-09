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
        #[Parameter(Mandatory=$true)]
        #[String]$name,
        #[Parameter(Mandatory=$true)]
        #[String]$model,        
        #[Parameter(Mandatory=$true)]
        #[String]$folderid,
        #[Parameter(Mandatory=$true)]
        #[String]$version,
        #[Parameter(Mandatory=$false)]
        #[String]$uid,
        [Parameter(Mandatory=$true)]
        $paneljson  
    )
    
    process {
        
        $url = "/api/library-elements"
        write-verbose $url
              
        #$body = @{
        #    uid = $uid
        #    folderId = $folderid
        #    name = $name
        #    model = $model
        #    kind = 1
        #    version = $version
        #}
    
        $jsonBody = ConvertTo-Json -InputObject $paneljson -Depth 100 -Compress  
        
        $ReturnValue = Invoke-GrafanaApi -url $url -method "PATCH" -Auth "Token" -Body $jsonBody

        return $ReturnValue
        
    }
}