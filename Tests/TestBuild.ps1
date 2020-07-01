# This runs in Docker
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

$modules = @(
    "BuildHelpers"
    "InstallModuleFromGit"
)

Write-Output "*** Installing build modules ***"
foreach($module in $modules){
    Install-Module -Name $module -Repository PSGallery -Verbose
}

# Check the online version if it exists
Write-Output "*** Test download from GitHub ***"
Import-Module InstallModuleFromGit -Verbose
Get-GitModule -ProjectUri https://github.com/sdaaish/MyModule -Branch develop -Verbose

# Install the local version in docker
Write-Output "*** Import current version of this module ***"
Import-Module /src/MyModule.psd1 -Force -Verbose
Install-MyModules -Verbose

# Print the local installed modules
Write-Output "*** List all locally installed modules ***"
(Get-ChildItem ".local/share/powershell/Modules").FullName
Get-Module -ListAvailable|Foreach-Object {"{0} {1} {2}" -f $_.Name, $_.ModuleBase, $_.Version}

# Print the current loaded modules
Write-Output "*** List all loaded modules ***"
Get-Module|Foreach-Object { "{0} {1} {2}" -f $_.Name, $_.ModuleBase, $_.Version }

#Invoke-ScriptAnalyzer /src/MyModule.psd1
Write-Output "*** Run ScriptAnalyzer on source ***"
Get-ChildItem -Recurse -Path /src -Filter *.ps*1 | Foreach-Object {"$($_.Name)"; Invoke-ScriptAnalyzer -Path $_.FullName}
