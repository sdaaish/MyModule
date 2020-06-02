# Get WSL SSH agent, from https://github.com/rupor-github/wsl-ssh-agent/
# Based on https://polansky.co/blog/a-better-windows-wsl-openssh-experience/
# Start with "wsl-ssh-agent.exe -setenv -envname WSL_AUTH_SOCK"
# Add this to WSL: "[ -n ${WSL_AUTH_SOCK} ] && export SSH_AUTH_SOCK=${WSL_AUTH_SOCK}"

Function Install-WslSShAgent {
    [cmdletbinding()]

    param(
        [Parameter(Mandatory)]
        $DestPath
    )

    try {
        Test-Path -Path $DestPath -PathType Container|Out-Null
    }
    catch {
        throw "Not a directory."
    }
    finally {
        $DestPath = Convert-Path $DestPath
    }

    try {
        Get-Command 7z.exe|Out-Null
    }
    catch {
        throw "7-Zip not found"
    }

    $release = Invoke-Restmethod "https://api.github.com/repos/rupor-github/wsl-ssh-agent/releases/latest"
    $uri= $release.assets.browser_download_url
    $version = $release.tag_name
    $tmp = [System.IO.Path]::GetFullPath((Join-Path -Path (Resolve-Path $DestPath) -ChildPath $release.assets.name))

    $start_time = Get-Date

    Write-Verbose "Downloading $uri to $tmp"
    Invoke-WebRequest -Uri $uri -OutFile $tmp -UseBasicParsing

  #  Expand-Archive $tmp $Path -Force
    $options = @(
        "x"
        "-y"
        "-bt"
        "-o${DestPath}"
        $tmp
    )
    Write-Verbose "7Zip: 7z $($options)"
    & 7z @options |Out-Null

    Write-Verbose "Extracted $tmp to $DestPath"
    Remove-Item $tmp -Force

    $time = $((Get-Date).subtract($start_time).seconds)
    Write-Output "Downloaded $($release.assets.name) version ${version} to $DestPath in $time seconds"
}
