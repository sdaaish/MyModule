Function Save-ModuleToLocal {
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$Name,

        [Switch]$AllowPreRelease
    )

    begin{
        if ($isLinux){
            $ModulePath = Resolve-Path "~/.local/share/powershell/Modules"
        }
        else {
            $ModulePath = Resolve-Path "~/.local/share/PowerShell/Modules"
        }
    }

    process {
        Save-Module -Name $Name -Path $ModulePath $PSBoundParameters
    }
}
