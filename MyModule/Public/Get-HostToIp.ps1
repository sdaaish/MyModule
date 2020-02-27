# Get IP address for a hostname
function Get-HostToIP {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)]
        $hostname
    )
    $result = [system.Net.Dns]::GetHostByName($hostname)
    $result.AddressList | ForEach-Object {$_.IPAddressToString }
}
