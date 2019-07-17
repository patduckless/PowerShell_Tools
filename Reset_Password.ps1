$cred = Get-Credential 
Invoke-Command -ScriptBlock {
$usrnme=Read-Host "Enter samAccountName" # get username that is to be reset
$passwrd=Read-Host "Enter new password" -AsSecureString # get new password
Set-ADAccountPassword $usrnme -NewPassword $passwrd # set new password
Set-ADUser $usrnme -ChangePasswordAtLogon $True # set the change password flag for the user. 
Enable-ADAccount $usrnme # Enabled the users account if locked
Unlock-ADAccount $usrnme
} -ComputerName <DC> -Credential $cred
Exit