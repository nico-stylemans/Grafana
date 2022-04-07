<# 
 Copyright 2022 Stylemans Nico
#> 

# Set-StrictMode -Version 3 

#region discover module name
$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
$ModuleName = $ExecutionContext.SessionState.Module
Write-Verbose -Message "Loading module $ModuleName"
#endregion discover module name


Set-StrictMode -Version latest

# if we are going to use the http client instead of invoke-restmethod
try {
    Add-Type -AssemblyName System.Net.Http -ErrorAction Stop
}
catch {
    $PSCmdlet.ThrowTerminatingError($_)
}

#region load module variables
Write-Verbose -Message "Creating modules variables"
#[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
#$UrlList = @{}
#$TokenList = @{}
#$TokenList.add('PROD', '123456')

$script:nsSession = $null 
 
$GrafanaApi = Import-Module -Name Grafana -PassThru

if($GrafanaApi)
{
    $script:PSModule.OnRemove = {
        Remove-Module -Name Grafana
    }
}
#region Handle Module Removal
$OnRemoveScript = {
    #Remove-Variable -Name TokenList -Scope Script -Force
}
$ExecutionContext.SessionState.Module.OnRemove += $OnRemoveScript
Register-EngineEvent -SourceIdentifier ([System.Management.Automation.PsEngineEvent]::Exiting) -Action $OnRemoveScript
#endregion Handle Module Removal


# Load public functions
try {
    $publicFunctions = Get-ChildItem -Path "$PSScriptRoot\Public" -Recurse -Include *.ps1 -Exclude *.tests.ps1 
    foreach ($function in $publicFunctions) { 
        . $function.FullName 
    } 
}
catch {
    Write-Error ("{0}: {1}" -f $function.FullName,$_.Exception.Message)
    exit 1
}
# Load private functions 
try {
    $privateFunctions = Get-ChildItem -Path "$PSScriptRoot\Private" -Recurse -Include *.ps1 -Exclude *.tests.ps1 
    foreach ($function in $privateFunctions) { 
        . $function.FullName 
    } 
}
catch {
    Write-Error ("{0}: {1}" -f $function.FullName,$_.Exception.Message)
    exit 1
}
