# mitmproxy
# https://hub.docker.com/r/mitmproxy/mitmproxy/
Function Start-MitmProxy {
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory)]
        $Path = "~/Downloads",
        $Config = "~/.mitmproxy",
        [int]$LocalPort = 8080,
        [string[]]$MitmOpts
    )

    if (-not (Test-Path $Config -PathType Container)){
        New-Item -Path $Config -ItemType Directory|Out-Null
    }

    Write-Verbose "Starting mitmproxy on port $LocalPort"
    $MitmConfig = Convert-Path $Config
    $Download = Convert-Path $Path
    $EXE = "docker"

    # Define parameters
    $params = "run","--rm","-it"
    $params += "-v", "$($MitmConfig -replace '\\','/'):/home/mitmproxy/.mitmproxy"
    $params += "-v", "$($Download -replace '\\','/'):/home/mitmproxy/tmp"
    $params += "-p", "127.0.0.1:${LocalPort}:8080"
    $params += "mitmproxy/mitmproxy", "mitmproxy", "${MitmOpts}"

    Write-Verbose "docker $params"
    & $EXE @params
}
