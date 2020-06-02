# https://stackoverflow.com/questions/51296568/powershell-convert-ip-address-to-subnet
function ConvertTo-IPv4MaskBits {
    [CmdLetBinding()]
    param(
        [parameter(Mandatory)]
        [ValidateScript({Test-IPv4MaskString $_})]
        [String] $MaskString
    )
    $mask = ([IPAddress] $MaskString).Address
    for ( $bitCount = 0; $mask -ne 0; $bitCount++ ) {
        $mask = $mask -band ($mask - 1)
    }
    $bitCount
}
