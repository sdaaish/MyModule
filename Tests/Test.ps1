#requires -modules BuildHelpers

[cmdletbinding()]
param()

Function Private:Copy-TestModule {
    [cmdletbinding()]
    param()

    $ModuleHome = Split-Path -Path $PSScriptRoot -Parent
    $ModuleName =  Split-Path -Path $ModuleHome -Leaf
    $ModulePath = Join-Path -Path $ModuleHome -ChildPath $ModuleName
    
    $ProjectFile = Join-Path -Path $ModuleHome -ChildPath $ModuleName -AdditionalChildPath "$ModuleName.psd1" 
    $ProjectName =  Get-ProjectName -Path $ProjectFile
    $ProjectVersion =  Get-Metadata -Path $ProjectFile
    
    $Destination = @{}

    $Platform = $PSVersionTable.Platform
    Switch ($Platform) {
        "Unix" {$Destination.Add( "LinuxPath", "${HOME}/.local/share/powershell/Modules/$ProjectName/$ProjectVersion")}
        "Win32NT" {$Destination.Add("WindowsPath", "$env:HomePATH/Documents/PowerShell/Modules/$ProjectName/$ProjectVersion")}
    }

    foreach($DestPath in $Destination.GetEnumerator()) {
        New-Item $DestPath.value -Force -ErrorAction Ignore
        Remove-Item -Recurse -Force $DestPath.value
        Copy-Item -Recurse $ModulePath $DestPath.value -Force
        Get-ChildItem $DestPath.value
    }
    Write-Verbose "Home: $ModuleHome"
    Write-Verbose "Name: $ModuleName"
    Write-Verbose "Path: $ModulePath"
    Write-Verbose "Project File: $ProjectFile"
    Write-Verbose "Project name and Version: $ProjectName $ProjectVersion"
    Write-Verbose "Destination: $($destination.values)"
}

Copy-TestModule
