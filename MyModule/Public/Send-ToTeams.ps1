function Send-ToTeams {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory)]
        [string]$WebHook,
        [Parameter(Mandatory)]
        [string]$Text
    )

    $payload = @{
        "text" = $Text
    }
    $json = ConvertTo-Json $payload
    Invoke-RestMethod -Method Post -ContentType "application/json;charset=UTF-8" -Body $json -Uri $WebHook
}
