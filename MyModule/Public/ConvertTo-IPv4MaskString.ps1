# https://stackoverflow.com/questions/51296568/powershell-convert-ip-address-to-subnet
function ConvertTo-IPv4MaskString {
    [CmdLetBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateRange(0, 32)]
        [Int] $MaskBits
    )
    $mask = ([Math]::Pow(2, $MaskBits) - 1) * [Math]::Pow(2, (32 - $MaskBits))
    $bytes = [BitConverter]::GetBytes([UInt32] $mask)
    (($bytes.Count - 1)..0 | ForEach-Object { [String] $bytes[$_] }) -join "."
}
