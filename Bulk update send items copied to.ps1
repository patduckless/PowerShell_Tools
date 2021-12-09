$users = Get-ADUser -Filter {UserPrincipalName -like "<UPN>*"} -SearchBase <SearchBase, probably an ou>
foreach($user in $users) { 
set-mailboxsentitemsconfiguration -Identity $user.Name -SendAsItemsCopiedTo SenderAndFrom -SendOnBehalfOfItemsCopiedTo SenderAndFrom
Out-Host -InputObject "Sent items save to $user.mail sent items folder... Set!"
}