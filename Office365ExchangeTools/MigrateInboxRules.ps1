#Import modules used in this script
Register-PSRepository -Default
Get-PSRepository
If(-not(Get-InstalledModule MSOnline -ErrorAction silentlycontinue)){
    Install-Module MSOnline -Confirm:$False -Force
}
Import-Module MSOnline

$O365CREDS = Get-Credential -message "Enter Office 365 Credentials... (Your UPN)"
$ONPREMCREDS = Get-Credential -message "Enter Local Record Exchange Admin... (Domain Admin)"

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $O365CREDS -Authentication Basic -AllowRedirection
Import-PSSession $Session

$OnPremExchange = Read-Host -Prompt "On prem exchange URL (e.g. exchange.contoso.com)"
$TargetDomain = Read-Host -Prompt "Exchange online URL (e.g. contoso.mail.onmicrosoft.com)"
$OnPremExchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://$OnPremExchange/PowerShell/ -Authentication Kerberos -Credential $ONPREMCREDS

## Get all mailboxes from pn premisis exchange server. 
Import-PSSession $OnPremExchangeSession
$AllMailboxes = Get-Mailbox
Exit-PSSession $OnPremExchangeSession

## Migrate all mailboxes to office 365. 
Connect-MsolService -credential $O365CREDS
foreach ($Mailbox in $AllMailboxes) {
    New-MoveRequest -Identity $Email -Remote -RemoteHostName $OnPremExchange -TargetDeliveryDomain $TargetDomain -RemoteCredential $ONPREMCREDS -BadItemLimit 5 -SuspendWhenReadyToComplete:$false -verbose
}
