# Install OhMyPosh with winget

Function Install-OhMyPosh {
    [cmdletbinding()]

    param(
    )

    try {
        & winget install JanDeDobbeleer.OhMyPosh
    }
    catch {
        throw "winget not installed."
    }
}
