Function Enable-HyperV {
    [cmdletbinding()]
    param()
    Enable-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM -NoRestart
}
