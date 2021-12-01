Function Set-MyEnvironment {
    [cmdletbinding()]
    Param (
        
    )

    begin {}
    process {
        if (-not $isLinux){
            [Environment]::SetEnvironmentVariable("GIT_SSH", $((Get-Command ssh.exe).Source), [System.EnvironmentVariableTarget]::User)
            [Environment]::SetEnvironmentVariable("HOME", $(Resolve-Path ${env:USERPROFILE}), [System.EnvironmentVariableTarget]::User)
            [Environment]::SetEnvironmentVariable("ALTERNATE_EDITOR", "runemacs.exe", [System.EnvironmentVariableTarget]::User)
        }
    }
    end {}
}
