# Gets several Eicar files and downloads them to the download-folder with random names
$uri = "http://2016.eicar.org/85-0-Download.html"
$eicar = Invoke-WebRequest -Uri $uri -UseBasicparsing -Verbose
$links = ($eicar.Links| Where href -match https://).href

if ($IsLinux){
    $tmppath = Resolve-Path ~/tmp
}
else {
    $tmppath = Resolve-Path ~/Downloads
}

foreach($link in $links){
    $filename = -join ((65..90) + (97..122) | Get-Random -Count 7 | ForEach-Object {[char]$_})
    $filename = Join-Path -Path $tmppath -ChildPath $filename
    Invoke-Webrequest -Uri $link -OutFile $filename -UseBasicParsing -Verbose
    Get-FileHash -Path $filename -Algorithm SHA256
}
