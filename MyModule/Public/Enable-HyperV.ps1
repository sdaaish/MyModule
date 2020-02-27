Function Enable-HyperV {
    [cmdletbinding()]
    param()
    Enable-WindowsOptionalFeature -Online -FeatureName containers -All -NoRestart
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart
}
