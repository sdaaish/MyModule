# Search StackOverFlow for Powershell stuff
Function Search-PowershellSX {

    $search += $args -join "+"

    if($search){
        $uri = "https://stackoverflow.com/search?q=%5Bpowershell%5D+" + "$search"
    }
    else {
        $uri = "https://stackoverflow.com/search?q=%5Bpowershell%5D+"
    }

    Start-Process $uri
}
