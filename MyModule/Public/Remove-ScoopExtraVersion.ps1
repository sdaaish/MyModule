# Remove old versions of scoop packages
Function Remove-ScoopExtraVersion {
    [cmdletbinding()]
    param()

    begin {
        Write-Output "Removing extra *User* app versions."
        $Apps = Get-ChildItem ~/scoop/apps}
    process{
        foreach($app in $Apps){
            Write-Verbose "Removing $app.name"
            scoop cleanup $app.name
        }

        if (Test-Administrator) {
        Write-Output "Removing extra *Global* app versions."
        $Apps = Get-ChildItem /ProgramData/scoop/apps
        foreach($app in $Apps){
            Write-Verbose "Removing $app.name"
            scoop cleanup -g $app.name
        }
        }
    }
}
