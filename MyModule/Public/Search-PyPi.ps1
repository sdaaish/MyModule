# Search Python module on PyPi
Function Search-PyPi {

    $search = $args -join "+"

    if($search){
        $uri = "https://pypi.org/search/?q={0}" -f $search
    }
    else {
        $uri = "https://pypi.org/search/"
    }

    Start-Process $uri
}
