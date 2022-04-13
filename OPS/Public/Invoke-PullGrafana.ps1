function Invoke-PullGrafana{
    <#
    .SYNOPSIS
        Function Get Grafana config to json output
    .DESCRIPTION
        
    .EXAMPLE
            Pull-Grafana -Login admin -Password Passw0rd -Token fsqjdfmlj -url http://localhost:3000
    .PARAMETER Login
        Login for Grafana authentication
    .PARAMETER Password
        Password for Grafana authentication
    .PARAMETER Token
        API token of Grafana organisation        
    .PARAMETER url
        Grafana root URL
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Login,
        [Parameter(Mandatory=$true)]
        [string]$Password,
        [Parameter(Mandatory=$true)]
        [string]$Token,
        [Parameter(Mandatory=$true)]
        [string]$url,
        [Parameter(Mandatory=$true)]
        [string]$path
    )
    Process {
        ##########################
        # Connect to grafana API #
        ##########################

        Connect-Grafana -Login $Login -Password $Password -Token $Token -url $url


        ###########################
        # Export Grafana Settings #
        ###########################

        If(!(test-path "$path\Settings"))
        {
            New-Item -ItemType Directory -Force -Path "$path\Settings"
        }
        
        $Settings = Get-GrafanaSettings
        $pathsettingsdata = "$Path\Settings\Settings.json"               
        $Settings | Out-File -FilePath $pathsettingsdata -Force
            

        ##########################
        # Export Grafana Folders #
        ##########################

        If(!(test-path "$path\Folders"))
        {
            New-Item -ItemType Directory -Force -Path "$path\Folders"
        }
        
        $Folders = Get-GrafanaFolder
        
        foreach($Folder in $Folders){
            
            $FolderUid = $($Folder.uid)
            $Folderjson = Get-GrafanaFolder -uid $FolderUid
            
            $pathfolderdata = "$Path\Folders\$($Folder.uid)-$($Folder.Title).json"
            $Folderjson | Out-File -FilePath $pathfolderdata -Force
            
            #$pathcontent = "$Path\$($Dashboard.uid)-$DashboardTitle-DBContent.json"
            #$dashboardcontentjson | Out-File -FilePath $pathcontent -Force
        }

        #############################
        # Export Grafana Dashboards #
        #############################

        If(!(test-path "$path\Dashboards"))
        {
            New-Item -ItemType Directory -Force -Path "$path\Dashboards"
        }
        
        $Dashboards = Get-GrafanaDashboard
        
        foreach($Dashboard in $Dashboards){
            
            $DashboardTitle = $($Dashboard.title)
            $DashboardTitle = $DashboardTitle -replace '/', ''
            $dashboardcontentjson = Export-GrafanaDashboard -id $Dashboard.id -latest
            
            $dsj = ConvertFrom-Json -InputObject $dashboardcontentjson
            $Dashboard | Add-Member -MemberType NoteProperty -Name 'data' -Value $dsj

            $dashboarddatajson = ConvertTo-Json -InputObject $Dashboard -Depth 100 -Compress
            $pathdbdata = "$Path\Dashboards\$($Dashboard.uid)-$DashboardTitle.json"
            $dashboarddatajson | Out-File -FilePath $pathdbdata -Force
            
            #$pathcontent = "$Path\$($Dashboard.uid)-$DashboardTitle-DBContent.json"
            #$dashboardcontentjson | Out-File -FilePath $pathcontent -Force
        }

        #############################
        # Disconnect to grafana API #
        #############################

        Disconnect-Grafana
    }
}