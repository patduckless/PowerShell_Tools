{
$username = "Username"
$password = Get-Content 'C:\Users\Administrator\Desktop\mysecurestring.txt' | ConvertTo-SecureString
$cred = new-object -typename System.Management.Automation.PSCredential `
         -argumentlist $username, $password
         }
Stop-Computer -ComputerName <computerName> -Credential $cred