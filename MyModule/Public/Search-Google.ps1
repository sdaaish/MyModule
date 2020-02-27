# Search google for stuff
Function Search-Google {

    $Search += $args -join "+"

    if($search){
        $uri = "https://www.google.com/search?q=" + "$search"
    }
    else {
        $uri = "https://www.google.com/search"
    }

    Start-Process $uri
}

