<#
Create missing remote mailboxes in local exchange.

Author: Patrick Duckles
Version: 1.0
#>

# Setup Credentials for connecting to remote services
$UPN = <EMAiL>
$O365CREDS = Get-Credential -message "Enter Office 365 Credentials... (Your UPN)" -UserName $UPN
$ONPREMCREDS = Get-Credential -message "Enter Local Record Exchange Admin... (Domain Admin)" -UserName "<EXCHANGE_ADMIN>"

# Create and connect to remote session xchng-ol  
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $O365CREDS -Authentication Basic -AllowRedirection
Import-PSSession $Session -AllowClobber

# Check for MSOnline module. If not found, install.
If(-not(Get-InstalledModule MSOnline -ErrorAction silentlycontinue)){
    Install-Module MSOnline -Confirm:$False -Force
}
Import-Module MSOnline
Connect-MsolService -credential $O365CREDS

# Get list of mailboxes present on o365 in the UK.
$data = get-mailbox -Filter {UsageLocation -eq "United Kingdom"}

# Close down xchng-ol session. 
Get-PSSession | Remove-PSSession

# Connect to local exhcnage server.
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri <URL OF EXCHANGESERVER> -Authentication Kerberos -Credential $ONPREMCREDS
Import-PSSession $Session -DisableNameChecking

# Run through each user. If they dont exsist as a remote mailbox in exchange, Create. Otherwise move on.
foreach($user in $data) {
$error.Clear()
$name = $user.Name.ToString()
$name = $name.replace("."," ")
Get-RemoteMailbox -Identity $name | out-null
if ($error -ne $null){
$RRA = $user.Alias + "@DOMAIN.LOCAL"
Enable-RemoteMailbox $user.Name -RemoteRoutingAddress $RRA
Set-RemoteMailbox $user.Name -ExchangeGuid $user.ExchangeGuid
}}

Get-PSSession | Remove-PSSession

if (!($psISE)){"Press any key to continue...";[void][System.Console]::ReadKey($true)}