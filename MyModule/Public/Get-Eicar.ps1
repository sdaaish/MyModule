# Gets several Eicar files and downloads them to the download-folder with random names
function Get-Eicar {

    [CmdletBinding()]
    param (
    $uri = "http://2016.eicar.org/85-0-Download.html"
    )

    begin {
    }

    process {
        $ErrorActionPreference = "SilentlyContinue"

        # Exceptions for dotnet and TLS
        [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
        #[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        #[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12

        $eicar = Invoke-WebRequest -Uri $uri -UseBasicparsing
        $links = ($eicar.Links | Where-Object href -match https://).href

        Write-verbose "Number of files: $($links.count)"
        Write-Verbose "$links"

        if ($IsLinux) {
            $tmppath = Resolve-Path ~/tmp
        }
        else {
            $tmppath = Resolve-Path ~/Downloads
        }

        foreach ($link in $links) {
            $filename = -join ((65..90) + (97..122) | Get-Random -Count 7 | ForEach-Object { [char]$_ })
            $filename = Join-Path -Path $tmppath -ChildPath $filename
            Write-Verbose "Starting download of $link as $filename"

            if ( $PSVersionTable.PSVersion.Major -le 5){ # Powershell 5 or less
                (New-Object System.Net.WebClient).DownloadFile($link, $filename)
            }
            else { #Powershell 7
                Invoke-WebRequest -UseBasicParsing -Uri $link -OutFile $filename
            }
            if (Test-Path $filename) {
                Write-Verbose "Checksum for $filename"
                $hash = Get-FileHash -Path $filename -Algorithm SHA256
                "{0}`t{1}" -f $hash.path,$hash.hash
            }
            else {
                Write-Verbose "Download of $filename did not succeed"
            }
        }
    }

    end {

    }
}
