# Install scoop.sh
# Works in Powershell 6 and later
Function Install-Scoop {
    [cmdletbinding()]
    param()
    try {
	Invoke-Expression (New-Object net.webclient).downloadstring('https://get.scoop.sh') -ErrorAction Stop
    }
    catch {
	Invoke-Expression "& {$(irm get.scoop.sh)} -RunAsAdmin"
    }
}
