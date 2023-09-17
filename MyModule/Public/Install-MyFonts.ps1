Function Install-MyFonts {

    [cmdletbinding()]
    param()

    # Check for Scoop.sh
    try {
        Get-Command scoop
    }
    catch {
        throw "Need to install scoop first, exiting."
    }

    # Need to run as administrator
    try {
        Test-Administrator
    }
    catch {
        throw "Need to run this as administrator"
    }
    finally {
        # Install preferred fonts with scoop
        scoop bucket add nerd-fonts
        scoop install sudo
        $fonts = @(
            "AnonymousPro-NF",
            "CodeNewRoman-NF",
            "DejaVuSansMono-NF",
            "Delugia-Nerd-Font-complete",
            "Delugia-Mono-Nerd-Font-complete",
            "FiraCode-NF",
            "FiraMono-NF",
            "Inconsolata-NF",
            "RobotoMono-NF",
            "SourceCodePro-NF",
            "Terminus-NF",
            "Ubuntu-NF"
        )


        foreach($font in $fonts){
            Write-Output "Installing $font"
            sudo scoop install --global $font
        }
    }

    $version = "v3.0.2"
    $uri = "https://github.com/ryanoasis/nerd-fonts/releases/download/${version}/"
    $nerdFonts = @{
        Caskaydia = "CascadiaCode.zip"
        Iosevka = "Iosevka.zip"
    }

    foreach ($font in ${nerdFonts}.GetEnumerator()) {

        $msg = "Downloading {0} Font" -f $font.key
        Write-Verbose $msg

        $archive = $font.key + ".zip"
        $zipfile = Join-Path $(Resolve-Path ~/Downloads) $archive
        $url = $uri + $font.value

        try {
            (New-Object System.Net.WebClient).DownloadFile($url, $zipfile)
        }
        catch {
            throw "Failed to download from ${url}."
        }
        finally {
            Write-Host "Downloaded $font to ${zipfile}."
        }
    }
}
