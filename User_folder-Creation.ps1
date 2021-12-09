<#
Title: Create_User_Home
Author: Patrick Duckles
Version: 2.0
Scope: Script to make new folder for new starting users and setting permissions.
#>
# Get Users Name
Function New-UserFolder
{
    Param (
        [String]$username,
        [string]$path
    )


    if ($username -eq $null)
    {
        Write-Host "To create a new user folder enter the six letter username from AD. This doesn't need the Domain\ on the start. " -ForegroundColor Yellow
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

    $folder = New-Item -ItemType Directory -Path $path -Name $username

    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($DomainUsername,"Modify", "ContainerInherit,ObjectInherit", "None", "Allow")

    $ACL = Get-Acl $folder
    $ACL.SetOwner([System.Security.Principal.NTAccount] $DomainUsername)
    $ACL.AddAccessRule($AccessRule)

    Set-Acl -Path $folder -AclObject $ACL

    $ACL.SetAccessRuleProtection($true, $true)
    Set-Acl -Path $folder -AclObject $ACL

    explorer.exe $folder
}