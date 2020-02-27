# Do a DNS lookup
function Resolve-Address {
    [cmdletbinding()]

    param(
        [Parameter(Mandatory)]
        $address
    )
    
    # Test if address is an IP
    try {
        $ip = ([ipaddress]$address).IPAddressToString
    }
    catch {
        # Otherwise check for a name
        try {
            ([System.Net.Dns]::GetHostByName($address)).
            AddressList.
            IPAddressToString
        }
        catch {
        }
    }

    # Check the IP for a name
    try {
        ([System.Net.Dns]::GetHostByAddress($ip)).Hostname
    }
    catch {
    }
}
