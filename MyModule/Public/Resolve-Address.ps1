# Do a DNS lookup
function Resolve-Address {
    [cmdletbinding()]

    param(
        [Parameter(Mandatory)]
        $address
    )

    # Test if the address does resolve
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
