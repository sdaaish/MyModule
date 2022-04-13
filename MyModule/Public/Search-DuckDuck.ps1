# Search DuckDuck for stuff
Function Search-DuckDuck {

    $Search += $args -join "+"

    if($search){
        $uri = "https://duckduckgo.com/?q=" + "$search"
    }
    else {
        $uri = "https://www.duckduckgo.com/search"
    }

    Start-Process $uri
}

