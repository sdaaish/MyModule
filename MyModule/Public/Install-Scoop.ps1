# Install scoop.sh
# Works in Powershell 6
Function Install-Scoop {
    [cmdletbinding()]
    param()
    Invoke-Expression (New-Object net.webclient).downloadstring('https://get.scoop.sh')
}
