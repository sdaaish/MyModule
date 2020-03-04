Function Get-WinVersion {
    [cmdletbinding()]
    Param (
    )

    $version = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WaaSAssessment\ -PSProperty Current).Current

    Write-Verbose "$version"
    $result = [PSCustomobject]@{
        Major = ($version.Split("."))[0]
        Minor =($version.Split("."))[1]
        Build =($version.Split("."))[2]
        Patch =($version.Split("."))[3]
    }
    $result
}
