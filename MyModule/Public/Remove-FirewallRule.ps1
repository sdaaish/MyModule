Function Remove-FirewallRule {
    [cmdletbinding()]
    Param (
        [Parameter(Mandatory)]
        [string]$Name
    )

    begin {
        try {
            Test-Administrator
        }
        catch {
            Write-Error "You need to be administrator for this."
            break
        }
    }

    process {
        Get-NetFirewallRule |
          Where-Object DisplayName -match $name |
          Remove-NetFirewallRule
    }

    end {}
}
