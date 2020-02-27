#requires -modules BuildHelpers

[cmdletbinding()]
param()

Function Private:Copy-TestModule {
    [cmdletbinding()]
    param()

    # Find out paths for the module
    $ModuleHome = Split-Path -Path $PSScriptRoot -Parent
    $ProjectManifest = Get-PSModuleManifest -Path $ModuleHome
    $ProjectName =  Get-ProjectName -Path $ProjectManifest
    $ProjectVersion =  Get-Metadata -Path $ProjectManifest

    # Source and destination for testing the module
    $ModuleSource = Join-Path -Path $ModuleHome -ChildPath $ProjectName
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

    Write-Verbose "ModuleHome: $ModuleHome"
    Write-Verbose "ModuleSource: $ModuleSource"
    Write-Verbose "Project File: $ProjectManifest"
    Write-Verbose "Project name and Version: $ProjectName $ProjectVersion"
    Write-Verbose "ModuleDestination: $($ModuleDestination.values)"
}

Copy-TestModule
