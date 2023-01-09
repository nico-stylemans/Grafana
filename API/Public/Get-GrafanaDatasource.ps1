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

        $url = "/api/datasources"

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
        
        $ReturnValue = Invoke-GrafanaApi -url $url -method "GET" -Auth "Token"

        return $ReturnValue

    
    }
}