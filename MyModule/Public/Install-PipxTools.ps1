<#
.SYNOPSIS
Install tools for formatting with pipx

.DESCRIPTION

#>
function Install-PipxTools {
    [CmdletBinding()]
    param(

    )

    begin {
        $tools = @(
            "autopep8"
            "black"
            "flake8"
            "isort"
            "mypy"
            "poetry"
            "pycompile"
            "pylint"
            "pyright"
            "pytest"
            "python-dotenv"
            "ruff"
            "ruff-lsp"
            "virtualenv"
            "yapf"
        )
    }
    process {

        try {
            Get-Command pipx.exe -ErrorAction Stop
            $tools.foreach({
                & pipx.exe install $_
            })
        }
        catch { throw "Pipx not installed"}

    }
}
