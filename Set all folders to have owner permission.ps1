Install-Module ExchangeOnlineManagement -Scope CurrentUser
Import-Module ExchangeOnlineManagement

COnnect-exchangeonline

$allfolders = Get-EXOMailbox -Identity <Email> | Get-MailboxFolder -Recurse
foreach($folder in $allfolders){
    Add-MailboxFolderPermission -identity $folder.Identity -User <user> -accessrights owner -ErrorAction silentlycontinue
}
