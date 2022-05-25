Function Enable-WindowsSandbox {
    [cmdletbinding()]
    param()
    Enable-WindowsOptionalFeature -FeatureName Containers-DisposableClientVM -All -Online -NoRestart
}
