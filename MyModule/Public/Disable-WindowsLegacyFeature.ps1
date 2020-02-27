# Disable legacy features
Function Disable-WindowsLegacyFeature {
    [cmdletbinding()]
    
    $features =  @(
        "internet-explorer-optional-amd64"
        "MicrosoftWindowsPowerShellV2Root"
        "MicrosoftWindowsPowerShellV2"
        "SMB1Protocol"
    )

    try {
        Test-Administrator
    }
    catch {
        throw "Missing administrative rights."
    }
    foreach ($feat in $features){
        Write-Output "Disabling $feat"
        Disable-WindowsOptionalFeature -Online -NoRestart -FeatureName $feat
    }
}
