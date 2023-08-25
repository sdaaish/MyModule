<#
.SYNOPSIS
Do a name lookup on Google DNS.

.DESCRIPTION
Does a name lookup on Google DNS using their API.
#>
function Resolve-DnsNameGoogle {
    [CmdletBinding()]
    param(
        [string]$Name,

        [ValidateSet("A","AAAA","ANY","MX","PTR","SOA","TXT")]
        [string]$Type = "A"
    )

    begin {
        $googleDns = "https://dns.google"
        if ($Type -eq "PTR") {
            $url = $googleDns + "/resolve?name=${Name}.in-addr.arpa&type=${Type}"

        }
        else {
            $url = $googleDns + "/resolve?name=${Name}&type=${Type}"
        }
    }

    process {
        $response = Invoke-RestMethod -Uri $url -Method "Get"

        $answer = $response.answer

        if (-not $answer){
            Write-Verbose "No values for ${Name} and ${Type}."
            $answer = [pscustomobject]@{
                name = ""
                TTL = ""
                data = ""
                RR = ""
            }
            return $answer
        }

        $answer|Add-Member -NotePropertyName "RR" -NotePropertyValue ""
        foreach($r in $answer){

            switch ($r.type) {
                1 {$rr = "A"}
                2 {$rr = "NS"}
                5 {$rr = "CNAME"}
                6 {$rr = "SOA"}
                13 {$rr = "HINFO"}
                15 {$rr = "MX"}
                16 {$rr = "TXT"}
                28 {$rr = "AAAA"}
                default {$rr = $r.type}
            }

            $r.RR = $rr
        }
        $answer| select-object -excludeproperty type
    }
}
