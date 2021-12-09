$forward = Import-Csv .\forward.csv

$forward | Foreach{ Set-Mailbox -Identity $_.FullName -DeliverToMailboxAndForward $true -ForwardingSMTPAddress "$_.ForwardTo"}