# Get Age encryption tool for Windows
Function Install-AgeTool {
    [cmdletbinding()]

    param(
        [Parameter(Mandatory)]
        $Path
    )

    try {
        Test-Path -Path $Path -PathType Container| Out-Null
    }
    catch {
        throw "Not a directory."
    }

    $tmp =  New-TemporaryFile
    $tmp = $tmp -replace("tmp$","zip")

    $versions = Invoke-Restmethod "https://api.github.com/repos/FiloSottile/age/releases/latest"
    $asset = $versions.assets| Where-Object name -match "windows-amd64"
    $uri = $asset.browser_download_url

    $zipfolder = Join-Path ${env:USERPROFILE} "\Downloads\agetool"

    $start_time = Get-Date

    (New-Object System.Net.WebClient).DownloadFile($uri,$tmp)
    Expand-Archive -Path $tmp -DestinationPath $zipfolder -Force
    Copy-Item ${zipfolder}\age\* -Destination $Path -Force

    Remove-Item $zipfolder -Recurse -Force
    Remove-Item $tmp -Force

    $time = $((Get-Date).subtract($start_time).seconds)
    Write-Output "Downloaded AgeTool to ${Path} in $time seconds"
}
