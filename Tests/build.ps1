#requires -modules BuildHelpers

# Build the testing docker image
Function Build-TestDocker {

  if ($isWindows) {
    $GitPath = Get-Command "git.exe"
  }
  else {
    $GitPath = Get-Command "git"
  }

  $Project = Get-BuildEnvironment -Path (Split-Path -Path $PSScriptRoot -Parent) -GitPath $GitPath
  $ProjectManifest = $Project.PSModuleManifest
  $ProjectName = $Project.ProjectName
  $ProjectVersion = Get-Metadata -Path $ProjectManifest
  $ProjectPath = $Project.ProjectPath
  $branch = $Project.BranchName
  $tag = "${ProjectName}-${branch}:${ProjectVersion}".ToLower()

  $dockeroptions = @(
    "--tag" , "$tag"
    "--file" , (Join-Path -Path $PSScriptRoot -ChildPath "Dockerfile")
  )
  Write-Output "*** Building docker environment ***"
  & docker build @dockeroptions $ProjectPath
}

# Testing the Docerfile itself
Function Test-DockerFile {
  $dockerfile = (Join-Path -Path $PSScriptRoot -ChildPath "Dockerfile")
  if ($isLinux) {
    $cmd = Get-Command "docker"
  }
  elseif ($isWindows) {
    $cmd = Get-Command "docker.exe"
  }

  $options = @(
    ($cmd.Source)
    "run --rm -i hadolint/hadolint"
  )

    Write-Output "*** Linting $dockerfile ***"
    Start-Process @options -RedirectStandardInput $dockerfile -NoNewWindow -Wait
}

Test-DockerFile
Build-TestDocker
