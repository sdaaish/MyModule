# mitmwb
# https://hub.docker.com/r/mitmproxy/mitmproxy/
Function Start-MitmWeb {
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory)]
        $Path = "~/Downloads",
        $Config = "~/.mitmproxy",
        [int]$LocalPort = 8080,
        [int]$LocalPortWeb = 8081,
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
    $params += "-p", "127.0.0.1:${LocalPortWeb}:8081"
    $params += "mitmproxy/mitmproxy", "mitmweb", "${MitmOpts}"

    $mitmopts = @(
        "--listen-host=0.0.0.0"
        "--listen-port=8080"
        "--web-host=0.0.0.0"
        "--web-port=8081"
    )
    
    Write-Verbose "docker $params"
    & $EXE @params @mitmopts
}
