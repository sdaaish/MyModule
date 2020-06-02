# Gets Windows version info from Registry
Function Get-WinVersion {
    [cmdletbinding()]
    Param (
    )

    Function Get-RegInfo {
        param(
            $regkey
        )
        $version = (Get-itemproperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\' -Name $regkey).$regkey
        Write-Verbose "$regkey $version"
        $version
    }

    if ($isLinux) {
        Throw "Not a windows host."
    }
    else{
        $result = [PSCustomobject]@{
            Major = (Get-RegInfo CurrentMajorVersionNumber)
            Minor = (Get-RegInfo CurrentMinorVersionNumber)
            Build = (Get-RegInfo CurrentBuild)
            Patch = (Get-RegInfo UBR)
        }
    }
    $result
}
