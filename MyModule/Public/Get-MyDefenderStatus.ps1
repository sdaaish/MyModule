Function Get-MyDefenderStatus {
    param(
    )

    function PrintStatus{

        param(
            $data,
            $status
        )


        $data.foreach(
            {
                $Name = (($_.Name).PadRight(50," "))
                $Value = $_.Value

                switch -regex ($Name){
                    ".*Enable*" {
                        if ($value){
                            Write-Host "${Name}: " -NoNewLine
                            write-host "${Value}" -foregroundcolor Green
                        }
                        else {
                            Write-Host "${Name}: " -NoNewLine
                            write-host "${Value}" -foregroundcolor Red
                        }
                    }
                    ".*Disable*" {
                        if (-not $value){
                            Write-Host "${Name}: " -NoNewLine
                            write-host "${Value}" -foregroundcolor Green
                        }
                        else {
                            Write-Host "${Name}: " -NoNewLine
                            write-host "${Value}" -foregroundcolor Red
                        }
                    }

                }
            }
        )

    }

    # Check the values that should be enabled
    $status = (Get-MpComputerStatus).psobject.properties | ? name -match enable|select Name, Value
    PrintStatus $status $true

    # Check the values that should be disabled
    $status = (Get-Mppreference).psobject.properties | ? name -match disable|select Name, Value
    PrintStatus $status $false
}
