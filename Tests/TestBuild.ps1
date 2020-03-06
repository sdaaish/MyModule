# This runs in Docker
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

$modules = @(
    "BuildHelpers"
    "InstallModuleFromGit"
)

foreach($module in $modules){
    Install-Module $module -Verbose
}

Import-Module InstallModuleFromGit -Verbose
Install-GitModule -ProjectUri https://github.com/sdaaish/MyModule -Branch develop -Verbose

Import-Module /src/MyModule.psd1 -Verbose
Install-MyModules -Verbose

(Get-ChildItem ".local/share/powershell/Modules").FullName

#Invoke-ScriptAnalyzer /src/MyModule.psd1
Get-ChildItem -Recurse -Path /src -Filter *.ps*1 | Foreach-Object {"$($_.Name)"; Invoke-ScriptAnalyzer -Path $_.FullName}
