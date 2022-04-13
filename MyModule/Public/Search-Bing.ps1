# Search Bing
Function Search-Bing {

    $search = $args -join "+"

    if($search){
        $uri = "https://www.bing.com/search?q=" + "$search"
    }
    else {
        $uri = "https://www.bing.com/search"
    }

    Start-Process $uri
}
