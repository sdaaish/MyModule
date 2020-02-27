<#

	.SYNOPSIS
This disables Internet Explorer

.DESCRIPTION
The script shows if Internet Explorer.

.EXAMPLE
./disable-ie.ps1

.NOTES
Put some notes here.

.LINK
#>

Function Disable-InternetExplorer {

    [cmdletbinding()]
    param()

    if (Test-Administrator){
        try {
            Disable-WindowsOptionalFeature -Online -FeatureName Internet-Explorer-Optional-amd64 -NoRestart
        }
        catch {
            "Internet Explorer is not installed"
        }
        finally {}
    }
    else {
        "Admin privilege required to run this command."
    }
}
