# Install scoop.sh
# Works in Powershell 6 and later
Function Install-Scoop {
    [cmdletbinding()]
    param()
    if (-not (Test-Administrator)) {
	Invoke-Expression (New-Object net.webclient).downloadstring('https://get.scoop.sh')
    }
    else
    {
	Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"
    }
}
