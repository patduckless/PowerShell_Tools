Function New-UserFolder
{
    Param (
        [String]$username
    )


    if ($username -eq $null)
    {
        Write-Host "To create a new user folder enter the six letter username from ADX. This doesn't need the AD\ on the start. " -ForegroundColor Yellow
        $username = Read-Host -Prompt "Enter Username"
    }

    if ($username.Length -ne 6)
    {
        Write-Host "Entered username is not six characters long. Are you sure this is correct? (Y/N)" -ForegroundColor Red -BackgroundColor Black 
        $overide = Read-Host 
        if ($overide -ne "Y")
        {
            Write-Host "Abort - Exiting" -ForegroundColor Yellow
            Return
        }
    }

    $DomainUsername = "AD\" + $username

    $folder = New-Item -ItemType Directory -Path D:\Shares\Users -Name $username

    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($DomainUsername, "FullControl", "Allow")

    $ACL = Get-Acl $folder
    $ACL.SetOwner([System.Security.Principal.NTAccount] $DomainUsername)
    $ACL.AddAccessRule($AccessRule)

    Set-Acl -Path $folder -AclObject $ACL

    $ACL.SetAccessRuleProtection($true, $true)
    Set-Acl -Path $folder -AclObject $ACL

    explorer.exe $folder
}