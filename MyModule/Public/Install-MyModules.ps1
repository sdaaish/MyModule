# Install my preferred modules
Function Install-MyModules {
    [cmdletbinding()]
    param()

    $StableModules = @(
        "Get-ChildItemColor"
        "PSReadline"
        "BuildHelpers"
        "PSScaffold"
        "Posh-Docker"
        "oh-my-PoSH"
        "InstallModuleFromGit"
    )

    $BetaModules = @(
        "Posh-Git"
        "PSReadLine"
    )

    $GitModules = @{
        MyModule = "https://github.com/sdaaish/MyModule", "develop"
    }

    # Check wich version of Powershell
    switch ($PSVersionTable.PSEdition){
        "Core" {$version = "PowerShell/Modules"}
        "Desktop" { $version = "WindowsPowerShell/Modules"}
    }

    # Resolve the path to modules depending on version of Powershell and OS
    if ($PSVersionTable.Platform -eq "Unix"){
        $NewModuleDirectory = [System.IO.Path]::GetFullPath((Join-Path -Path (Resolve-Path "~") -ChildPath ".local/share/powershell/Modules"))  
    }
    #Windows
    else {
        $LocalDirectory = [System.IO.Path]::GetFullPath((Join-Path -Path (Resolve-Path "~") -ChildPath ".local"))
        $NewModuleDirectory = Join-Path -Path $LocalDirectory -ChildPath $version
    }
    Write-Verbose "New module-path: $NewModuleDirectory"

    try {
        Test-Path $NewModuleDirectory -ErrorAction Stop-Process
    }
    catch {
        New-Item -Path $NewModuleDirectory -ItemType Directory -Force|Out-Null
    }


    Set-PSRepository -name PSGallery -InstallationPolicy Trusted

    foreach ($module in $StableModules){
        Write-Host "Installing module $module"
        Save-Module -Name $module -Path $NewModuleDirectory
    }

    foreach ($module in $BetaModules){
        Write-Host "Installing module $module"
        Save-Module -Name $module -path $NewModuleDirectory -AllowPrerelease -Force
    }

    Import-Module InstallModuleFromGit
    foreach ($key in $GitModules.GetEnumerator()){
        $module = $key.key
        $src = $key.value[0]
        $branch =  $key.value[1]
        Write-Host "Installing module $module from $src and branch $branch"
        $temp = Get-GitModule -ProjectURI $src -Branch $branch -KeepTempCopy

        # Crazy workaround at the moment
        $options = @{
            Path = (Join-Path $temp.LocalPath $temp.ManifestName)
            Destination = (Join-Path $NewModuleDirectory (Join-Path $temp.ManifestName $temp.Version))
        }
        Copy-Item -Recurse -Force @options
        Remove-Item -Recurse -Force $temp.LocalPath
    }
}
