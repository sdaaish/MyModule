# Creates eldoc-file with powershell info
Function New-PSEldoc {

    [cmdletbinding()]
    param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [string]$Path
    )

    function Get-Signature ($Cmd) {

        Write-Verbose "$Cmd"

        if ($Cmd -is [Management.Automation.PSMethod]) {
            $List = @($Cmd)
        }
        elseif ($Cmd -isnot [string]) {
            throw ("Get-Signature {<method>|<command>}`n" + "$Cmd is not a method or command")
        }
        else {
            $List = @(Get-Command $Cmd -ErrorAction SilentlyContinue)
        }

        if ($List[0] ) {
            foreach ($O in $List) {
                switch -regex ($O.GetType().Name) {
                    'AliasInfo' {
                        Get-Signature ($O.Definition)
                    }
                    '(Cmdlet|ExternalScript)Info' {
                        $O.Definition}          # not sure what to do with ExternalScript
                    'F(unction|ilter)Info'{
                        if ($O.Definition -match '^param *\(') {
                            $t = [Management.Automation.PSParser]::tokenize($O.Definition,
                                                                            [ref]$null)
                            $c = 1
                            $i = 1
                            while($c -and $i++ -lt $t.count) {
                                switch ($t[$i].Type.ToString()) {
                                    GroupStart {$c++}
                                    GroupEnd   {$c--}
                                }
                            }
                            $O.Definition.substring(0,$t[$i].start + 1)  #needs parsing
                        }
                        else {
                            $O.Name
                        }
                    }
                    'PSMethod' {
                        foreach ($t in @($O.OverloadDefinitions)) {
                            while (($b=$t.IndexOf('`1[[')) -ge 0) {
                                $t=$t.remove($b,$t.IndexOf(']]')-$b+2)
                            }
                            $t
                        }
                    }
                }
            }
        }
    }

    Get-Command|
      ?{$_.CommandType -ne 'Alias' -and $_.Name -notlike '*:'}|
      %{$_.Name}|
      Sort-Object|
      %{("(set (intern ""$($_.Replace('\','\\'))"" powershell-eldoc-obarray)" +
         " ""$(Get-Signature $_|%{$_.Replace('\','\\').Replace('"','\"')})"")"
        ).Replace("`r`n"")",""")")}|Out-File $Path
}
