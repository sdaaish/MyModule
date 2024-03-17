# Search Cheat.sh for Linux manpages
Function Search-LinuxMan {
    [cmdletbinding()]
    [alias("cht", "Search-CheatSh")]

    param(
        [string]$ManPage,

        [ValidateSet("algol","algol_nu","arduino","autumn","borland","bw","colorful","default",
                     "emacs","friendly","fruity","igor","inkpot","lovelace","manni","monokai",
                     "murphy","native","paraiso-dark","paraiso-light","pastie","perldoc","rainbow_dash",
                     "rrt","sas","solarized-dark","solarized-light","stata","stata-dark","stata-light",
                     "tango","trac","vim","vs","xcode")]
        $Style = "emacs",

        [switch]$NoComment
    )

    $url = "https://cheat.sh/"
    $manpage = $manpage -replace " ","+"

    if ($NoComment){
        $Quiet = '&Q'
    }

    if($manpage){
        $uri = "{0}/{1}?style={2}{3}" -f $url,$manpage,$style,$Quiet
    }
    else {
        $uri = "{0}/:help" -f $url
    }

    $response = Invoke-WebRequest $uri
    $response.content
}
