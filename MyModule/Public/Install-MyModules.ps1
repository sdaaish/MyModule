# Install my preferred modules
Function Install-MyModules {
    [cmdletbinding()]
    param()

    $StableModules = @(
        "AnyPackage"
        "AnyPackage.Scoop"
        "BuildHelpers"
        "BurntToast"
        "DockerCompletion"
        "DockerComposeCompletion"
        "DockerMachineCompletion"
        "F7History"
        "Get-ChildItemColor"
        "Microsoft.PowerShell.ConsoleGuiTools"
        "PSFzf"
        "PSScaffold"
        "PSScriptAnalyzer"
        "Pester"
        "Posh-Docker"
				"Posh-Git"
        "PowerShellForGitHub"
        "PSReadLine"
        "Terminal-Icons"
        "Watch-Command"
        "WindowsSandboxTools"
        "oh-my-PoSH"
        "z"
    )

    $BetaModules = @(
    )

    $GitModules = @{
				#        MyModule = "https://github.com/sdaaish/MyModule", "develop"
    }

    # Check which version of Powershell
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


    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

    foreach ($module in $StableModules){
        Write-Output "Installing module $module"
        Start-Job -Name $module -ScriptBlock {Save-Module -Name $module -Path $NewModuleDirectory -Repository PSGallery}
    }

    Get-Job|Wait-Job -TimeOut 120

    foreach ($module in $BetaModules){
        Write-Output "Installing module $module"
        Start-Job -Name $module -ScriptBlock {Save-Module -Name $module -path $NewModuleDirectory -Repository PSGallery -AllowPrerelease -Force}
    }

    Get-Job|Wait-Job -TimeOut 120

}
