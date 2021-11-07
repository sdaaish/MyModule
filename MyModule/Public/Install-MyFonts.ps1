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
            "Cascadia-Code",
            "Cascadia-NF-Mono",
            "Cascadia-NF",
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
}
