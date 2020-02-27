# Step buildnumber and store as UTF8
#Requires -Modules Buildhelpers
Function Step-ModuleVersionUTF8 {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$True)]
        $ModuleFile,
        [ValidateSet("Build", "Major","Minor","Patch")]
        [string]$Step = "Patch"
    )
    Import-module Buildhelpers

    if (Test-Path $ModuleFile){
        Step-ModuleVersion -Path $modulefile -By $Step
        $content = Get-Content $modulefile
        Set-Content -Path $modulefile -Value $content -Encoding UTF8
    }
    else {
        throw "No such file $ModuleFile"
    }
}
