# Search Bing
Function Search-LinuxMan {

    param(
        $manpage
    )

    if($manpage){
        $uri = "https://cheat.sh/" + "$manpage"
    }
    else {
        $uri = "https://cheat.sh"
    }

    $response = Invoke-WebRequest $uri
    $response.content
}
