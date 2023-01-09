function New-GrafanaTeamMember{
    <#
    .SYNOPSIS
        Add new Member to Team
    .DESCRIPTION

    .EXAMPLE
        
    .PARAMETER id
        Team id
    .PARAMETER Userid
        User id
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$id,
        [Parameter(Mandatory=$true)]
        [string]$userid
    )
    
    process{
        
        $url = "/api/teams/$id/members"  
               
        write-verbose $url
        
        $member = @{ 
            userId = $userid
        }
           
        $body = ConvertTo-Json -InputObject $member -Depth 100 -Compress  

        $ReturnValue = Invoke-GrafanaApi -url $url -method "POST" -body $body 

        return $ReturnValue
        
    }
}