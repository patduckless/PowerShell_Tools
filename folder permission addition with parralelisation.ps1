$tlfolders = Get-ChildItem -Directory
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("<group or user>", "FullControl", "Allow")
foreach ($curfolder in $tlfolders)
{
    $ACL = Get-Acl $curfolder
    $ACL.AddAccessRule($AccessRule)
    Set-Acl -Path $curfolder -AclObject $ACL
    $folders = Get-ChildItem -Path $curfolder
    Start-Job -ScriptBlock {
        foreach ($folder in $folders)
        {
            $ACL = Get-Acl $folder
            $ACL.AddAccessRule($AccessRule)
            Set-Acl -Path $folder -AclObject $ACL
        }
    }
}