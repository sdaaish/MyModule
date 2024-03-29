# From https://exchangepedia.com/2017/11/get-file-or-folder-permissions-using-powershell.html
Function Get-Permissions ($folder) {

    (Get-Acl $folder).Access |
      Select-Object `
      @{Label="Identity";Expression={$_.IdentityReference}}, `
      @{Label="Right";Expression={$_.FileSystemRights}}, `
      @{Label="Access";Expression={$_.AccessControlType}}, `
      @{Label="Inherited";Expression={$_.IsInherited}}, `
      @{Label="Inheritance Flags";Expression={$_.InheritanceFlags}}, `
      @{Label="Propagation Flags";Expression={$_.PropagationFlags}} |
      Format-Table -AutoSize
}
