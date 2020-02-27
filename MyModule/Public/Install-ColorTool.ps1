# Get Windows Colortool
Function Install-ColorTool {
    [cmdletbinding()]

    param(
        [Parameter(Mandatory)]
        $Path
    )

    try {
        Test-Path -Path $Path -PathType Container
    }
    catch {
        throw "Not a directory."
    }
    
    $tmp =  New-TemporaryFile
    
    $terminal = Invoke-Restmethod "https://api.github.com/repos/Microsoft/Terminal/releases/latest"
    $release = $terminal.tag_name
    $uri = "https://github.com/microsoft/Terminal/releases/download/$release/ColorTool.zip"
    
    $start_time = Get-Date

    Write-Verbose "Downloading $uri"
    Invoke-WebRequest -Uri $uri -OutFile $tmp -UseBasicParsing

    Expand-Archive $tmp $Path -Force
    Write-Verbose "Extracted $tmp to $Path"

    $time = $((Get-Date).subtract($start_time).seconds)
    Write-Output "Downloaded Colorest.exe to $Path\ColorTool.exe in $time seconds"
}
