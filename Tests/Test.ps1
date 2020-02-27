<#
.SYNOPSIS
Copies the module from repository to the modulepath.

.DESCRIPTION
TBD

.PARAMETER Foobar
None

.EXAMPLE
./Test/Test.ps1

.NOTES
Used to test that tha module works.
#>

#requires -modules BuildHelpers

[cmdletbinding()]
param()

Function Private:Copy-TestModule {
    [cmdletbinding()]
    param()

    # Find out paths for the module
    $Project = Get-BuildEnvironment (Split-Path -Path $PSScriptRoot -Parent)
    $ProjectManifest = $Project.PSModuleManifest
    $ProjectName =  $Project.ProjectName
    $ProjectVersion =  Get-Metadata -Path $ProjectManifest

    # Source and destination for testing the module
    $ModuleSource = Join-Path -Path $Project.ProjectPath -ChildPath $ProjectName
    $ModuleDestination = @{}

    $Platform = $PSVersionTable.Platform
    Switch ($Platform) {
        "Unix" {$ModuleDestination.Add( "LinuxPath", "${HOME}/.local/share/powershell/Modules/$ProjectName/$ProjectVersion")}
        "Win32NT" {$ModuleDestination.Add("WindowsPath", "$env:HomePATH/Documents/PowerShell/Modules/$ProjectName/$ProjectVersion")}
    }

    foreach($DestPath in $ModuleDestination.GetEnumerator()) {
        New-Item $DestPath.value -Force -ErrorAction Ignore
        Remove-Item -Recurse -Force $DestPath.value
        Copy-Item -Recurse $ModuleSource $DestPath.value -Force
        Get-ChildItem $DestPath.value
    }

    Write-Verbose "Project Home: $($Project.ProjectPath)"
    Write-Verbose "Project Manifest: $ProjectManifest"
    Write-Verbose "Project Name: $ProjectName and Version: $ProjectVersion"
    Write-Verbose "Module Source: $ModuleSource"
    Write-Verbose "Module Destination: $($ModuleDestination.values)"
}

Copy-TestModule
