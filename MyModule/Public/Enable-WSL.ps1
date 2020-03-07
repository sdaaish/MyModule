# Enables WSL
Function Enable-WSL {
    [cmdletbinding()]
    param()

    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName Microsoft-Windows-Subsystem-Linux
}
