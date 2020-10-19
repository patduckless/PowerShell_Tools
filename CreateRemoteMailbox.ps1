<#
Create missing remote mailboxes in local exchange.

Author: Patrick Duckles
Version: 1.0
#>

# Setup Credentials for connecting to remote services
$DomainName = Read-Host -Prompt "What is the name of your domain? e.g Contoso Corp would be @contoso.com"
$LocalExchange = Read-Host -Prompt "What is the URI of your Local Exchange server? e.g. Contoso Corp would use Exchange.Contoso.com."
$UPN = (($env:USERNAME).replace(" ", ".") + "$DomainName")
$O365CREDS = Get-Credential -message "Enter Office 365 Credentials... (Your UPN)" -UserName $UPN
$ONPREMCREDS = Get-Credential -message "Enter Local Exchange Admin..."

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
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $LocalExchange -Credential $ONPREMCREDS -Authentication Basic -AllowRedirection
Import-PSSession $Session -AllowClobber

# Run through each user. If they dont exsist as a remote mailbox in exchange, Create. Otherwise move on.
foreach($user in $data) {
$error.Clear()
$name = $user.Name.ToString()
Get-RemoteMailbox -Identity $name | out-null
if ($error -ne $null){
$RRA = $user.Alias + "$DomainName"
Enable-RemoteMailbox $user.Name -RemoteRoutingAddress $RRA
Set-RemoteMailbox $user.Name -ExchangeGuid $user.ExchangeGuid
}}

if (!($psISE)){"Press any key to continue...";[void][System.Console]::ReadKey($true)}
