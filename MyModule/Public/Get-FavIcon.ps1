<#

	.SYNOPSIS
  Downloads a favicon.ico-file from a domain.

	.DESCRIPTION

	.EXAMPLE

	.NOTES
	Put some notes here.

	.LINK
	https://github.com/sdaaish/powershell-stuff

	From Technet: https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_comment_based_help
#>

# Read the domain
Function Get-FavIcon {
    [cmdletbinding()]

    param (
        [string] $Domain,
        [string] $OutFile = (Resolve-Path "~/Downloads/favicon.ico")
    )

    if ($Domain){
        if ($Domain -like "www*") {
            $uri = "http://" + $domain + "/favicon.ico"
        }
        else {
            $uri = "http://www." + $domain + "/favicon.ico"
        }
        try {
            Invoke-Webrequest -Uri $uri -OutFile $outfile -Timeout 3 -Erroraction:Stop
        }
        catch {
            throw "Could not download $uri"
        }
        Write-host -Foreground:green "Done downloading $outfile"
    }
    else {
        Write-Host "Usage: ./Get-FavIcon -Domain domainname -OutFile <file>"
    }
}
