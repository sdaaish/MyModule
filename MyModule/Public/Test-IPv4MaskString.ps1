#https://stackoverflow.com/questions/51296568/powershell-convert-ip-address-to-subnet
function Test-IPv4MaskString {
    [CmdLetBinding()]
    param(
        [Parameter(Mandatory)]
        [String] $MaskString
    )
    $validBytes = '0|128|192|224|240|248|252|254|255'
    $MaskString -match `
    ('^((({0})\.0\.0\.0)|'      -f $validBytes) +
    ('(255\.({0})\.0\.0)|'      -f $validBytes) +
    ('(255\.255\.({0})\.0)|'    -f $validBytes) +
    ('(255\.255\.255\.({0})))$' -f $validBytes)
}
