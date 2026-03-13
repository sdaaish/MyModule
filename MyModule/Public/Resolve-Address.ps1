# Do a DNS lookup
function Resolve-Address {
    [cmdletbinding()]

    param(
        [Parameter(Mandatory)]
        $address
    )

    # Test if address is an IP
    try {
        $response = [System.Net.Dns]::GetHostEntry($address)
    }
    catch {
        $null
        break
    }

    if ($response.HostName -match $address){
        $response.AddressList.IPAddressToString
    }
    else{
        $response.HostName
    }
}
