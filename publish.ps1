# Local publish to Azure Devops Artifacts/NuGet Repository
# Not part of Azure DevOps CI/CD Pipeline/Artifacts

[cmdletbinding()]
Param (
    $Path        = $PSScriptRoot,
    $NuGetApiKey = $ENV:NuGetApiKey,
    $Repository  = "AzurePSModuleRepo"
)

Import-Module Buildhelpers
$BuildEnvironment = Get-BuildEnvironment -Path $Path

$version = Get-Metadata -Path $BuildEnvironment.PSModuleManifest
"$version"

$buildPath =  Join-Path $BuildEnvironment.ProjectPath  "/build"
"$buildpath"

$nuspec = $BuildEnvironment.PSModuleManifest -replace ("psd1", "nuspec")
nuget pack $nuspec -Version $version -OutputDirectory $buildPath

"Publishing [$Destination]:${version} to [$PSRepository]"
$nupkg = (Get-ChildItem -Path $build -Filter ${BuildEnvironment.ProjectName}*nupkg).Fullname
nuget push  $nupkg -Source $Repository -Apikey $NuGetApiKey

