Function Save-ModuleToLocal {
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$Name
    )

    begin{
        if ($isLinux){
            $ModulePath = Resolve-Path "~/.local/share/powershell/Modules"
        }
        else {
            # Check wich version of Powershell
            switch ($PSVersionTable.PSEdition){
                "Core" {$version = "PowerShell/Modules"}
                "Desktop" { $version = "WindowsPowerShell/Modules"}
            }
            $ModulePath = Join-Path -Path (Resolve-Path "~/.local") -ChildPath $version
        }
    }

    process {
        Save-Module -Name $Name -Path $ModulePath
    }
}
