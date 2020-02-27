# Install WSL
# From https://blogs.msdn.microsoft.com/commandline/2018/11/05/whats-new-for-wsl-in-the-windows-10-october-2018-update/
# For other distros, https://docs.microsoft.com/en-us/windows/wsl/install-manual
# Adds the username '$user' with the password 'password'. Change this after you login.
Function Install-WSL {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,
        [Parameter(Mandatory=$true)]
        [string]$User
    )

    # Download the file without displaying progress
    $ProgressPreference = "SilentlyContinue"
    Write-Verbose "Downloading..."
    Invoke-WebRequest -Uri "https://aka.ms/wsl-ubuntu-1804" -OutFile $Path -UseBasicParsing
    $ProgressPreference = "Continue"

    Write-Verbose "Installing package $Path"
    Add-AppxPackage -Path $Path
    RefreshEnv

    Write-Verbose "Configuring WSL for $User"
    Ubuntu1804 install --root
    Ubuntu1804 run "apt update"
    Ubuntu1804 run "apt upgrade -y"
    Ubuntu1804 run "apt install -y git make"
    Ubuntu1804 run "printf '[automount]\nroot = /\noptions = \U022metadata\U022\n' > /etc/wsl.conf"
    Ubuntu1804 run "groupadd -g 1000 $User"
    Ubuntu1804 run "useradd -u 1000 -g 1000 -G sudo -d /home/$User -m -s /bin/bash $User"
    Ubuntu1804 run "usermod -p '`$6`$OiB0Vesp`$W2pekhjHU.BMIKdnGnzBPy93pqA5j9UHFQ2uT94i4ukixVkCN/xomc9mWtkBCKCkFndGKDkVdzVR45EpUkcV51' $User"
    Ubuntu1804 config --default-user $User
    Remove-Item -Force -Path $Path
}
