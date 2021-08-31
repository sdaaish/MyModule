#Requires -PSEdition Desktop

# Install WSL
# From https://blogs.msdn.microsoft.com/commandline/2018/11/05/whats-new-for-wsl-in-the-windows-10-october-2018-update/
# For other distros, https://docs.microsoft.com/en-us/windows/wsl/install-manual
# Adds the username '$user' with the password 'password'. Change this after you login.

# Currently only works well in Powershell Desktop

Function Install-WSL {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter(Mandatory)]
        [string]$DefaultUser,

        [Parameter(Mandatory)]
        [validateset("Ubuntu20","Ubuntu18","Ubuntu16","Debian")]
        [string]$Distribution
    )

    switch ($Distribution) {
        "Ubuntu20" {
            $Uri = "https://aka.ms/wslubuntu2004"
            $Command = "ubuntu2004.exe"
        }
        "Ubuntu18" {
            $Uri = "https://aka.ms/wsl-ubuntu-1804"
            $Command = "ubuntu1804.exe"
        }
        "Ubuntu16" {
            $Uri = "https://aka.ms/wsl-ubuntu-1604"
            $Command = "ubuntu1604.exe"
        }
        "Debian" {
            $Uri = "https://aka.ms/wsl-debian-gnulinux"
            $Command = "debian.exe"
        }
    }

    # Set default to WSL2
    Write-Verbose "Enabling WSL 2"
    & wsl --set-default-version 2 | Out-Null

    # Download the file without displaying progress
    $ProgressPreference = "SilentlyContinue"
    Write-Verbose "Downloading, please wait..."
    Invoke-WebRequest -Uri $Uri -OutFile $Path -UseBasicParsing
    Write-Verbose "Downloaded $Path from $Uri"
    $ProgressPreference = "Continue"

    Import-Module Appx
    Write-Verbose "Installing package $Path"
    Add-AppxPackage -Path $Path
    RefreshEnv | Out-Null

    Write-Verbose "Configuring WSL for $DefaultUser"
    & $Command install --root
    & $Command run --user root "apt update"
    & $Command run --user root "apt upgrade -y"
    & $Command run --user root "apt install -y git make"
    & $Command run --user root "printf '[automount]\nroot = /\noptions = \U022metadata\U022\n' > /etc/wsl.conf"
    & $Command run --user root "groupadd -g 1000 $DefaultUser"
    & $Command run --user root "useradd -u 1000 -g 1000 -G sudo -d /home/$DefaultUser -m -s /bin/bash $DefaultUser"
    & $Command run --user root "usermod -p '`$6`$OiB0Vesp`$W2pekhjHU.BMIKdnGnzBPy93pqA5j9UHFQ2uT94i4ukixVkCN/xomc9mWtkBCKCkFndGKDkVdzVR45EpUkcV51' $DefaultUser"
    & $Command config --default-user $DefaultUser
    Remove-Item -Force -Path $Path
}
