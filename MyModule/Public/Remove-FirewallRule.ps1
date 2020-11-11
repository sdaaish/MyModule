Function Remove-FirewallRule {
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$Name
    )

    begin {
        if (-not (Test-Administrator)){
            throw "You need to be administrator for this."
        }
    }

    process {
        Get-NetFirewallRule |
          Where-Object DisplayName -match $name |
          Remove-NetFirewallRule
    }

    end {}
}
