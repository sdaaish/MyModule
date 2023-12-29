# Search Cheat.sh for Linux manpages
Function Search-LinuxMan {

    param(
        $manpage,
        $style = "emacs"
    )

    $url = "https://cheat.sh/"

    if($manpage){
        $uri = "{0}/{1}?style={2}" -f $url,$manpage,$style
    }
    else {
        $uri = $url
    }

    $response = Invoke-WebRequest $uri
    $response.content
}
