# Install scoop.sh
# Works in Powershell 6
Function Install-Scoop {
    [cmdletbinding()]
    param()
    try {Invoke-Expression (New-Object net.webclient).downloadstring('https://get.scoop.sh')}
    catch {}
}
