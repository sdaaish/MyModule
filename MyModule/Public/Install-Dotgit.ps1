# My local files in a bare git repo
Function Install-DotGit {
    [cmdletbinding(
         SupportsShouldProcess,
         ConfirmImpact = 'High'
     )]
    Param (
        [Switch]$Force
    )

    if  ($isLinux){
    }
    else {
        if ($Force){
            $ConfirmPreference = 'None'
        }

        $gitdir = Join-Path ${env:USERPROFILE} ".dotgit"
        $workdir = ${env:USERPROFILE}
        $tmpdir = Join-Path ${env:USERPROFILE} "tmpdir"
        $gitrepo = "https://github.com/sdaaish/windotfiles.git"
        $cmd = Get-Command git.exe

        New-Item -Path $tmpdir -ItemType Directory -Force|Out-Null

        # Options to clone github to tmp-dir with separate git-repo
        $options = @(
            "clone"
            "--separate-git-dir=${gitdir}"
            "$gitrepo"
            "${tmpdir}"
        )
        Write-Verbose "$cmd @options"
        & $cmd @options

        # Copy files recursivly
        if ($Force -or $PSCmdlet.ShouldProcess($gitdir,'Overwrite  files')){
            Copy-Item -Path $tmpdir/* -Destination $workdir -Recurse -Force
        }
        else {
            Copy-Item -Path $tmpdir/* -Destination $workdir -Recurse
        }

        $options = @(
            "--git-dir=${gitdir}"
            "--work-tree=${workdir}"
        )

        # Add default settings
        Write-Verbose "$cmd @options config status.showUntrackedFiles no"
        & $cmd @options config status.showUntrackedFiles no

        # Clone submodules
        Write-Verbose "$cmd @options submodule update --init --force --remote --recursive"
        & $cmd @options submodule update --init --force --remote --recursive

        # Delete tmp
        if ($Force -or $PSCmdlet.ShouldProcess($tmpdir,'Remove files')){
            Remove-Item -Path $tmpdir -Recurse -Force
        }
	else {
	    Remove-Item -Path $tmpdir -Recurse
        }
    }
}
