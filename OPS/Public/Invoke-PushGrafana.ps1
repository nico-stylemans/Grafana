function Invoke-PushGrafana{
    <#
    .SYNOPSIS
        Function Push Grafana config from json
    .DESCRIPTION
        
    .EXAMPLE
            Push-Grafana -Login admin -Password Passw0rd -Token fsqjdfmlj -url http://localhost:3000
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
        # IMPORY Grafana Settings #
        ###########################

        ##############################
        # IMPORT Grafana Datasources #
        ##############################

        If(!(test-path "$path\DataSources"))
        {
            Return "Datasource folder does not exists!"
        }
        
        $DataSources = Get-ChildItem -Path "$path\DataSources" -File
                
        foreach($Datasource in $DataSources){
            
            $SecurJsonFields = @{}
            $SecretError = $false
            $securefield = $false

            $Datasourceobj = Get-Content -Path $Datasource.FullName | ConvertFrom-Json
                        
            if (Get-Member -inputobject $datasourceobj -name "secureJsonFields" -Membertype Properties){
                $SecretFields = $Datasourceobj.secureJsonFields
                $securefield = $true
            
                foreach($key in $SecretFields.psobject.properties) {
                    $SecretToGet = "$($Datasourceobj.uid)-$($key.name)"
                    $secret = Get-AzKeyVaultSecret -VaultName $keyvaultname -Name $SecretToGet -AsPlainText
                    if ($null -ne $secret) {
                        $SecurJsonFields.add($key.name, $secret)
                    } else {
                        Write-host "Error 001 Keyvault : Secret with name : $($key.name) not found"
                        $SecretError = $true
                    }
                }
            }

            if ( (!$securefield) -or ($securefield -and !$SecretError)) {
                
                if ($securefield){
                    $myObject = [pscustomobject]$SecurJsonFields    # Tranform Hashtable
                    $Datasourceobj | Add-Member -MemberType NoteProperty -Name secureJsonData -Value $myObject
                    $Datasourceobj.PSObject.Properties.Remove('secureJsonFields')
                }
                
                $DatasourceContentJson = ConvertTo-Json -InputObject $Datasourceobj -Depth 100 #-Compress
                #$pathdsdata = "$Path\DataSources\test.json"
                #$DatasourceContentJson | Out-File -FilePath $pathdsdata -Force
                $existingdashboard = Get-GrafanaDatasource -uid $Datasourceobj.uid
                if ($existingdashboard.StatusCode -eq "401") {
                    New-GrafanaDatasource -dsjson $DatasourceContentJson
                }
                else {
                    Update-GrafanaDatasource -id $Datasourceobj.id -dsjson DatasourceContentJson
                }
            }
            else {
                Write-host "Error 002 Datasource : Datasource $($Datasourceobj.name) not added due to missing secrets"
            }
        }

        ##########################
        # IMPORT Grafana Folders #
        ##########################

        If(!(test-path "$path\Folders"))
        {
            Return "Folders folder does not exists!"
        }
        
        $Folders = Get-ChildItem -Path "$path\Folders" -File
                
        foreach($Folder in $Folders){

            $Folderobj = Get-Content -Path $Folder.FullName | ConvertFrom-Json
            
            $existingfolder = Get-GrafanaFolder -uid $Folderobj.uid #| ConvertFrom-Json

            if ($existingfolder.StatusCode -eq "404") {
                New-GrafanaFolder -Name $Folderobj.title -uid $Folderobj.uid
            }
            else {
                Update-GrafanaFolder -Name $Folderobj.title -uid $Folderobj.uid
            }
 
        }

        ######################################
        # IMPORT Grafana Folders Permissions #
        ######################################

        If(!(test-path "$path\Folders\Permissions"))
        {
            Return "folder\Permissions does not exists!"
        }
        
        $FoldersPerms = Get-ChildItem -Path "$path\Folders\Permsissions" -File
                
        foreach($FolderPerm in $FoldersPerms){

            $FolderPermobj = Get-Content -Path $FolderPerm.FullName | ConvertFrom-Json
            
            Update-GrafanaFolderPermissions -uid $FolderPermobj.uid -json $FolderPermobj
            
        }

        #########################
        # IMPORT Grafana Panels #
        #########################

        If(!(test-path "$path\Panels"))
        {
            Return "Panels folder does not exists!"
        }
        
        $Panels = Get-ChildItem -Path "$path\Panels" -File
                
        foreach($Panel in $Panels){

            $Panelobj = Get-Content -Path $Panel.FullName | ConvertFrom-Json
            $Panelobj.PSObject.Properties.Remove('meta')
            $Panelobj.PSObject.Properties.Remove('version')
            
            $PanelobjJson = ConvertTo-Json -InputObject $Panelobj -Depth 100
            $existingpanel = Get-GrafanaPanels -uid $Panelobj.uid # | ConvertFrom-Json
            if ($existingpanel.StatusCode -eq "404") {
                New-GrafanaPanel -paneljson $PanelobjJson
            } else {
                Update-GrafanaPanel -paneljson $PanelobjJson
            }

        }

        #############################
        # IMPORT Grafana Dashboards #
        #############################

        If(!(test-path "$path\Dashboards"))
        {
            Return "Dashboard folder does not exists!"
        }
        
        $Dashboards = Get-ChildItem -Path "$path\Dashboards" -File
                
        foreach($Dashboard in $Dashboards){

            $Dashboardobj = Get-Content -Path $Folder.FullName | ConvertFrom-Json
            
            $existingdashboard = Get-GrafanaDashboard -uid $Dashboardobj.uid #| ConvertFrom-Json

            if ($existingdashboard.StatusCode -eq "404") {
                New-GrafanaDashboard -dsjson $Dashboardobj
            }
            else {
                New-GrafanaDashboard -dsjson $Dashboardobj
            }
 
        }

        ########################################
        # IMPORT Grafana Dashboard Permissions #
        ########################################

        If(!(test-path "$path\Dashboards\Permissions"))
        {
            Return "Dashboards\Permissions does not exists!"
        }
        
        $DashboardPerms = Get-ChildItem -Path "$path\Dashboards\Permsissions" -File
                
        foreach($DashboardPerm in $DashboardPerms){

            $DashboardPermobj = Get-Content -Path $DashboardPerm.FullName | ConvertFrom-Json
            
            Update-GrafanaDashboardPermissions -uid $DashboardPermobj.uid -json $DashboardPermobj
            
        }
        
    }
}