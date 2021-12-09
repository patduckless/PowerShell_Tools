
Function Reset-PasswordAge {
    
    Param (
        [Parameter (Mandatory=$True)] [String] $SamAccountName,
        [String] $DNSDomainName = $ENV:USERDOMAIN,
        [Bool] $Force
    )
    Try 
    {
        # Get the user properties from AD
        $ADUser = Get-ADUser -Identity $SamAccountName -Properties Name,pwdLastSet,PasswordNeverExpires -Server $DNSDomainName
    }
    Catch 
    {
         Write-Host "User ($SamAccountName) not found. Aborting." -ForegroundColor Red
         Return
    }

    $Culture = Get-Culture

    # Get todays date and format it correctly.
    $Today = Get-Date -Format ($Culture.DateTimeFormat.FullDateTimePattern)

    # Get the date of the last password change and format it correctly.
    $LastChange = Get-Date -Date ([DateTime]::FromFileTime($ADUser.pwdLastSet)) -Format ($Culture.DateTimeFormat.FullDateTimePattern)
    Write-Host "Last Password ($SamAccountName) change on: $LastChange" -ForegroundColor Yellow

    If ($Force -eq $true) 
    {
        # Set the password to expired, must be done first.
        $ADUser.pwdLastSet = 0
        # Set the account so that the password expires.
        $ADUser.PasswordNeverExpires = $False
        # Save the changes
        Set-ADUser -Instance $ADUser -Server $DNSDomainName

        # Reset the date of the last password change to today.
        $ADUser.pwdLastSet = -1
        # Save the changes
        Set-ADUser -Instance $ADUser -Server $DNSDomainName

        # Inform the user of the script that the account was changed.
        Write-Host "Last Password ($SamAccountName) changed to: $Today" -ForegroundColor Green
    }    
}

#Reset-Password -SamAccountName "A.User" -Force $true
