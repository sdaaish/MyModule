<#
.SYNOPSIS
.DESCRIPTION
#>
function Update-Version {
    [CmdletBinding()]
    param(

    )

    process {
        $project = Get-BuildEnvironment -Path $PSScriptRoot
        $project
        Step-ModuleVersion -Path $project.PSModuleManifest -By Patch

        $file = Get-GitChangedFile -Path $project.ProjectPath
        $file.foreach(
            {
                Invoke-Git -Path $project.Projectpath -GitPath (gcm git.exe) -Arguments "add $file"
            }
        )
        $meta = Get-MetaData -Path $project.PSModuleManifest
        $meta

        Invoke-Git -Path $project.Projectpath -GitPath (gcm git.exe) -Arguments "commit -m ""Update to version ${meta}"""
        Invoke-Git -Path $project.Projectpath -GitPath (gcm git.exe) -Arguments "tag $meta ${project.commithash}"
    }
}
Update-Version
