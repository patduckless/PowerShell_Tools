<#
This Script is designed to be used in conjunction with the task scheduler to email the user whenever
An unsecured LDAP request is made to the domain controller. 

It helps root out sources of unsecured LDAP requests to secure your network.
#>

$ID = @("2886","2887","2888","2889")
$Events = Get-WinEvent -LogName "Directory Service" -MaxEvents 100 | Where-Object ID -in $ID
$Body = Out-String -InputObject $Events

Send-MailMessage -SmtpServer <SMTP RELAY> -Subject "Unsecured LDAP Request Recieved" -Body $Body -From <FROM> -To <TO> 
