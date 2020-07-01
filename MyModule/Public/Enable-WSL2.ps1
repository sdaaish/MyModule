# Enables WSL2 which works without Hyper-V
Function Enable-WSL2 {
    [cmdletbinding()]
    param()

    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName Microsoft-Windows-Subsystem-Linux
    Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName VirtualMachinePlatform
}
