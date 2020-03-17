# Install WSL
# From https://blogs.msdn.microsoft.com/commandline/2018/11/05/whats-new-for-wsl-in-the-windows-10-october-2018-update/
# For other distros, https://docs.microsoft.com/en-us/windows/wsl/install-manual
# Adds the username '$user' with the password 'password'. Change this after you login.

Function Install-WSL {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path,
        [Parameter(Mandatory)]
        [string]$User,
        [Parameter(Mandatory)]
        [validateset("Ubuntu18","Ubuntu16","Debian")]
        [string]$Distribution
    )

    switch ($Distribution){
        "Ubuntu18" {
            $Uri = "https://aka.ms/wsl-ubuntu-1804"
            $Command = "ubuntu1804.exe"
        }
        "Ubuntu16" {
            $Uri = "https://aka.ms/wsl-ubuntu-1604"
            $Command = "ubuntu.exe"
        }
        "Debian" = {
            $Uri = "https://aka.ms/wsl-debian-gnulinux"
            $Command = "debian.exe"
        }
    }

    # Download the file without displaying progress
    $ProgressPreference = "SilentlyContinue"
    Write-Verbose "Downloading..."
    Invoke-WebRequest -Uri $Uri -OutFile $Path -UseBasicParsing
    $ProgressPreference = "Continue"

    Write-Verbose "Installing package $Path"
    Add-AppxPackage -Path $Path
    RefreshEnv

    Write-Verbose "Configuring WSL for $User"
    $Command install --root
    $Command run "apt update"
    $Command run "apt upgrade -y"
    $Command run "apt install -y git make"
    $Command run "printf '[automount]\nroot = /\noptions = \U022metadata\U022\n' > /etc/wsl.conf"
    $Command run "groupadd -g 1000 $User"
    $Command run "useradd -u 1000 -g 1000 -G sudo -d /home/$User -m -s /bin/bash $User"
    $Command run "usermod -p '`$6`$OiB0Vesp`$W2pekhjHU.BMIKdnGnzBPy93pqA5j9UHFQ2uT94i4ukixVkCN/xomc9mWtkBCKCkFndGKDkVdzVR45EpUkcV51' $User"
    $Command config --default-user $User
    Remove-Item -Force -Path $Path
}
