Function Enable-WindowsSandbox {
    [cmdletbinding()]
    param()
    Enable-WindowsOptionalFeature -Online -FeatureName Containers-DisposableClientVM -NoRestart
}
