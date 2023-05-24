# Get the resulting url from an shortend url.
Function Get-ShortUrl {
    param(
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [string]
        $Url
    )

    $Web = Invoke-WebRequest -Uri $Url -UseBasicParsing

    switch ($PSEdition) {
        "Core" { $Web.BaseResponse.RequestMessage.RequestUri.AbsoluteUri }
        "Desktop" { $Web.BaseResponse.ResponseUri.AbsoluteUri }
    }
}
