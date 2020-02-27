# Search StackExchange for Emacs stuff
Function Search-EmacsSX {

    $search += $args -join "+"

    if($search){
        $uri ="https://emacs.stackexchange.com/search?q=" + "$search"
    }
    else {
        $uri = "https://emacs.stackexchange.com/search"
    }

    Start-Process $uri
}
