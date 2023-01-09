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

        if ($Settings.Statuscode -ne "200" ) {
            Write-Verbose "No Settings found"
        }
        else {

            $Settingsjson = ConvertTo-Json -InputObject $Settings.Data -Depth 100 #-Compress
            $pathsettingsdata = "$Path\Settings\Settings.json"               
            $Settingsjson | Out-File -FilePath $pathsettingsdata -Force
        }    

        ##########################
        # Export Grafana Folders #
        ##########################

        If(!(test-path "$path\Folders"))
        {
            New-Item -ItemType Directory -Force -Path "$path\Folders"
        }
        If(!(test-path "$path\Folders\Permissions"))
        {
            New-Item -ItemType Directory -Force -Path "$path\Folders\Permissions"
        }
        $Folders = Get-GrafanaFolder
        if ($Folders.Statuscode -ne "200" ) {
            Write-Verbose "No Folders found"
        }
        else {
                        
            foreach($Folder in $Folders.Data){
                
                $FolderUid = $($Folder.uid)
                $Folderdata = Get-GrafanaFolder -uid $FolderUid
                
                $Folderjson = ConvertTo-Json -InputObject $Folderdata -Depth 100 #-Compress
                $pathfolderdata = "$Path\Folders\$($Folder.uid)-$($Folder.Title).json"
                $Folderjson | Out-File -FilePath $pathfolderdata -Force
                
                $Folderperm = Get-GrafanaFolderPermissions -uid $FolderUid
                if ($Folderperm.Statuscode -eq "200"){
                    
                    $Folderpermjson = ConvertTo-Json -InputObject $Folderperm.Data -Depth 100 #-Compress
                    $pathfolderperm = "$Path\Folders\Permissions\$($Folder.uid)-Permissions.json"
                    $Folderpermjson | Out-File -FilePath $pathfolderperm -Force
                }
            }            
        }

        ##############################
        # Export Grafana Datasources #
        ##############################

        If(!(test-path "$path\DataSources"))
        {
            New-Item -ItemType Directory -Force -Path "$path\DataSources"
        }
        
        $DataSources = Get-GrafanaDatasource
        
        if ($DataSources.Statuscode -ne "200" ) {
            Write-Verbose "No Datasources found"
        }
        else {
        
            foreach($Datasource in $DataSources.Data){
                
                #$DatasourceName = $($Datasource.name)
                #$DatasourceName = $DatasourceName -replace '/', ''
                $Datasourcedata = Get-GrafanaDatasource -uid $Datasource.uid
                if ($Datasourcedata.Statuscode -eq "200" ) {
                                
                    $DatasourceContentJson = ConvertTo-Json -InputObject $Datasourcedata.Data -Depth 100 #-Compress
                    $pathdsdata = "$Path\DataSources\$($Datasource.uid)-$($Datasource.name).json"
                    $DatasourceContentJson | Out-File -FilePath $pathdsdata -Force
                }             
            }
        }

        #############################
        # Export Grafana Dashboards #
        #############################

        If(!(test-path "$path\Dashboards"))
        {
            New-Item -ItemType Directory -Force -Path "$path\Dashboards"
        }

        If(!(test-path "$path\Dashboards\Permissions"))
        {
            New-Item -ItemType Directory -Force -Path "$path\Dashboards\Permissions"
        }
        
        $ReturnDashboards = Get-GrafanaDashboard
        
        if ($ReturnDashboards.StatusCode -ne "200"){
            Write-Verbose "No Dashboards found"
        }
        else {

            $Dashboards = $ReturnDashboards.Data

            foreach($Dashboard in $Dashboards){
                
                $DashboardTitle = $($Dashboard.title)
                $DashboardTitle = $DashboardTitle -replace '/', ''
                $dashboardcontent = Export-GrafanaDashboard -id $Dashboard.id -latest
                
                if ($dashboardcontent.StatusCode -eq "200") {


                    #$dsj = ConvertFrom-Json -InputObject $dashboardcontentjson
                    $Dashboard | Add-Member -MemberType NoteProperty -Name 'data' -Value $dashboardcontent.data #$dsj

                    $dashboarddatajson = ConvertTo-Json -InputObject $Dashboard -Depth 100 #-Compress
                    $pathdbdata = "$Path\Dashboards\$($Dashboard.uid)-$DashboardTitle.json"
                    $dashboarddatajson | Out-File -FilePath $pathdbdata -Force
                    
                    $Dashperm = Get-GrafanaDashboardPermissions -uid $Dashboard.uid
                    if ($Dashperm.StatusCode -eq "200") {

                        $Dashpermjson = ConvertTo-Json -InputObject $Dashperm.Data -Depth 100 #-Compress
                        $pathdashperm = "$Path\Dashboards\Permissions\$($Dashboard.uid)-Permissions.json"
                        $Dashpermjson | Out-File -FilePath $pathdashperm -Force
                    }
                }
                else {
                    Write-Verbose "Error Getting DashboardContent for uid $Dashboard.id"
                }
            }
        }

        #################################
        # Export Grafana Library Panels #
        #################################

        If(!(test-path "$path\Panels"))
        {
            New-Item -ItemType Directory -Force -Path "$path\Panels"
        }
        
        $Panels = Get-GrafanaPanels
        if ($Panels.StatusCode -ne "200"){
            Write-Verbose "No Panels found"
        }
        else {
            foreach($Panel in $Panels.Data.result.elements){
                
                $PanelJson = ConvertTo-Json -InputObject $Panel -Depth 100 #-Compress
                $pathpldata = "$Path\Panels\$($Panel.uid)-$($Panel.name).json"
                $PanelJson | Out-File -FilePath $pathpldata -Force  
                
            }
        }

        ########################
        # Export Grafana Teams #
        ########################

        If(!(test-path "$path\Teams"))
        {
            New-Item -ItemType Directory -Force -Path "$path\Teams"
        }

        If(!(test-path "$path\Teams\Members"))
        {
            New-Item -ItemType Directory -Force -Path "$path\Teams\Members"
        }

        If(!(test-path "$path\Teams\Preferences"))
        {
            New-Item -ItemType Directory -Force -Path "$path\Teams\Preferences"
        }
        
        $ReturnTeams = Get-GrafanaTeam
        
        if ($ReturnTeams.StatusCode -ne "200"){
            Write-Verbose "No Teams found"
        }
        else {

            $Teams = $ReturnTeams.Data

            foreach($Team in $Teams.teams){
                
                $TeamName = $($Team.name)
                
                $Teamdatajson = ConvertTo-Json -InputObject $Team -Depth 100 #-Compress
                $pathteamdata = "$Path\Teams\$($Team.id)-$TeamName.json"
                $Teamdatajson | Out-File -FilePath $pathteamdata -Force
                    
                # Get Team Members
                
                $TeamMembers = Get-GrafanaTeamMember -id $Team.id
                if ($TeamMembers.StatusCode -eq "200") {

                        $tmjson = ConvertTo-Json -InputObject $TeamMembers.Data -Depth 100 #-Compress
                        $pathtm = "$Path\Teams\Members\$($Team.id)-Members.json"
                        $tmjson | Out-File -FilePath $pathtm -Force
                }

                # Get Team Preference
                
                $returnpref = Get-GrafanaTeamPreference -id  $Team.id
                if ($returnpref.StatusCode -eq "200") {

                    $prefjson = ConvertTo-Json -InputObject $returnpref.Data -Depth 100 #-Compress
                    $pathpref = "$Path\Teams\Preferences\$($Team.id)-Preferences.json"
                    $prefjson | Out-File -FilePath $pathpref -Force
                }
            }
        }

        #############################
        # Disconnect to grafana API #
        #############################

        Disconnect-Grafana
    }
}