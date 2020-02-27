# Get som Powershell books and examples for reference.
Function Get-PowershellBooks {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    $path = Convert-Path $path

    if (Test-Path $path) {
        # Lee Holmes
        git -C $path clone https://resources.oreilly.com/examples/0636920024132.git "PowerShell CookBook Examples"

        # Douglas Finke
        git -C $path clone https://github.com/dfinke/powershell-for-developers.git "PowerShell for Developers"

        # Adam Bertram
        git -C $path clone https://github.com/adbertram/Automate-The-Boring-Stuff-With-PowerShell.git "Automate the Boring Stuff with Powershell"
    }
    else {
        Write-Error "No such path: $path"
    }
}
