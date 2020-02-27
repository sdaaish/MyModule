# Search bing for powershell examples
# Bing has preview of powershell code which is nice
Function Search-PowershellBing {
    
    $search = "powershell+"
    $search += $args -join "+"

    if($search){
        $uri = "https://www.bing.com/search?q=" + "$search"
    }
    else {
        $uri = "https://www.bing.com/search"
    }

    Start-Process $uri
}
