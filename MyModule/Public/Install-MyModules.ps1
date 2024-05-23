# Install my preferred modules
Function Install-MyModules {
    [cmdletbinding()]
    param()

    $StableModules = @(
        "AnyPackage"
        "AnyPackage.Scoop"
        "BuildHelpers"
        "DnsClient-PS"
        "DockerCompletion"
        "DockerComposeCompletion"
        "DockerMachineCompletion"
        "F7History"
        "Get-ChildItemColor"
        "ImportExcel"
        "PSScriptAnalyzer"
        "Microsoft.PowerShell.ConsoleGuiTools"
        "Microsoft.PowerShell.SecretManagement"
        "Microsoft.PowerShell.SecretsStore"
        "Microsoft.Winget.Client"
        "PSFzf"
        "PSScaffold"
        "PSScriptAnalyzer"
        "PSScriptTools"
        "Pester"
        "Posh-Docker"
				"Posh-Git"
        "PowerShellForGitHub"
        "PSReadLine"
        "Terminal-Icons"
        "Watch-Command"
        "WindowsSandboxTools"
        "oh-my-PoSH"
    )

    # BurntToast only works on Windows
    if ($PSVersionTable.PSEdition -eq "Desktop" -or $isWindows){
        $StableModules += "BurntToast"
    }

    # These are installed in pre-release
    $BetaModules = @(
        "SecretManagement.KeePass"
    )

    # To be removed
    $GitModules = @{
				#        MyModule = "https://github.com/sdaaish/MyModule", "develop"
    }

    # Check which version of Powershell
    switch ($PSVersionTable.PSEdition){
        "Core" {$version = "PowerShell/Modules"}
        "Desktop" { $version = "WindowsPowerShell/Modules"}
    }

    # Resolve the path to modules depending on version of Powershell and OS
    if ($isLinux){
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

    # Install stable modules
    $StartTime = Get-Date
    foreach ($module in $StableModules){
        Write-Output "Installing module $module"
        $Jobs = Start-Job -Name $module -ScriptBlock {Save-Module -Name $using:module -Path $using:NewModuleDirectory -Repository PSGallery}
    }

    Get-Job|Wait-Job -TimeOut 120|Remove-Job

    $msg = "Installed {0} modules in {1:mm}:{1:ss}." -f ($StableModules.count), (New-Timespan -Start $StartTime -End (Get-Date))
    Write-Verbose $msg

    # Install PreRelease modules
    $StartTime = Get-Date
    foreach ($module in $BetaModules){
        Write-Output "Installing module $module"
        $Jobs = Start-Job -Name $module -ScriptBlock {Save-Module -Name $using:module -path $using:NewModuleDirectory -Repository PSGallery -AllowPrerelease -Force}
    }

    # Run the jobs and wait
    Get-Job|Wait-Job -TimeOut 120|Remove-Job

    $msg = "Installed {0} modules in {1:mm}:{1:ss}." -f ($BetaModules.count), (New-Timespan -Start $StartTime -End (Get-Date))
    Write-Verbose $msg

    # Show message
    $toastParams = @{
        Text = "Installation done" -f $timeTaken,$date
        Header = (New-BTHeader -Id 1 -Title "Setup Done")
    }
    New-BurntToastNotification @toastParams
}
