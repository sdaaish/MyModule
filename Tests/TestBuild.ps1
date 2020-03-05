Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

$modules = @(
    "BuildHelpers"
    "InstallModuleFromGit"
)

foreach($module in $modules){
    Install-Module $module
}

Import-Module InstallModuleFromGit
Install-GitModule -ProjectUri https://github.com/sdaaish/MyModule -Branch develop
