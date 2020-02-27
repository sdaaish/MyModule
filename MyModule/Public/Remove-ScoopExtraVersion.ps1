# Remove old versions of scoop packages
Function Remove-ScoopExtraVersion {
    [cmdletbinding()]
    param()
    
    Write-Host "Removing extra *User* app versions."
    $Apps = Get-ChildItem ~/scoop/apps
    foreach($app in $Apps){
        Write-Verbose "Removing $app.name"
        scoop cleanup $app.name
    }

    if (Test-Administrator) {
        Write-Host "Removing extra *Global* app versions."
        $Apps = Get-ChildItem /ProgramData/scoop/apps
        foreach($app in $Apps){
            Write-Verbose "Removing $app.name"
            scoop cleanup -g $app.name
        }
    }
}
