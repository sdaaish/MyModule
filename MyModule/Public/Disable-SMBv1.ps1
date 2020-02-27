<#

	.SYNOPSIS
	This disables SMBv1

	.DESCRIPTION
	The script shows if SMBv1.

	.EXAMPLE
./disable-smbv1

.NOTES
Put some notes here.

.LINK
#>

Function Disable-SMBv1 {

    [cmdletbinding()]
    param()

    if (Test-Administrator){
        try {
            Disable-WindowsOptionalFeature -Online -FeatureName smb1protocol -NoRestart
            Get-SmbServerConfiguration | Select EnableSMB1Protocol, EnableSMB2Protocol
        }
        catch {
            throw "Some error"
        }
        finally {}
    }
    else {
        "Admin privilege required to run this command."
    }
}

