#
# Module manifest for module 'Grafana'
#
# Generated by: Stylemans Nico
#
# Generated on: 04/04/2022
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'Grafana-api.psm1'

# Version number of this module.
ModuleVersion = '2.0.2'

# Supported PSEditions
#CompatiblePSEditions = 'Desktop', 'Core'

# ID used to uniquely identify this module
GUID = 'f97dff4c-b263-4d0c-a5a3-c2113193fe60'

# Author of this module
Author = 'Stylemans Nico'

# Company or vendor of this module
CompanyName = 'Stylemans Nico'

# Copyright statement for this module
Copyright = '(c) 2022 Stylemans Nico. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Grafana API'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '7.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Connect-Grafana', 'Disconnect-Grafana', 'Export-GrafanaDashboard', 
                    'Get-GrafanaDatasource', 'Get-GrafanaDashboard', 'Get-GrafanaDashboardVersion', 
                    'New-GrafanaDashboard', 'Get-GrafanaFolder', 'New-GrafanaFolder',
                    'Remove-GrafanaFolder', 'Update-GrafanaFolder', 'Get-GrafanaSettings', 
                    'New-GrafanaDatasource', 'Update-GrafanaDatasource', 'Get-GrafanaPanels',
                    'New-GrafanaPanel', 'Update-GrafanaPanel',  'Get-GrafanaFolderPermissions',
                    'Get-GrafanaDashboardPermissions', 'Update-GrafanaFolderPermissions', 'Update-GrafanaDashboardPermissions',
                    'Get-GrafanaTeam', 'New-GrafanaTeam', 'Update-GrafanaTeam', 'Remove-GrafanaTeam',
                    'Get-GrafanaTeamMember', 'New-GrafanaTeamMember', 'Remove-GrafanaTeamMember',
                    'Get-GrafanaTeamPreference', 'Update-GrafanaTeamPreference' 

#FunctionsToExport = @()

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
         Tags = "Grafana", "API"

        # A URL to the license for this module.
         LicenseUri = 'https://github.com/nico-stylemans/Grafana/blob/main/LICENSE'

        # A URL to the main website for this project.
         ProjectUri = 'https://github.com/nico-stylemans/Grafana'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

