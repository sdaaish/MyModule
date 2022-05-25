# From https://exchangepedia.com/2017/11/get-file-or-folder-permissions-using-powershell.html
Function Get-Properties ($path) {
    #exit if path not found
    if (-not ($path | Test-Path)) {
        Write-Host "$path not found. Please specify a valid file or folder path." -foregroundcolor red
        return }

    $o = New-Object -com Shell.Application
    $item = Get-Item $path

    if ($item.gettype() -eq [System.IO.DirectoryInfo]) {
	Write-Host "Found folder $path... Getting properties"
	$fso = $o.Namespace("$path")
	$fso.self.InvokeVerb("properties")
    }

    if ($item.gettype() -eq [System.IO.FileInfo])
    {Write-Host "Found file $path... Getting properties"
     $fso = $o.Namespace($item.directoryname)
     $file = $fso.parsename($item.pschildname)
     $file.InvokeVerb("properties")
    }
}
