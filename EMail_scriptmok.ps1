$username = "<userName>"
$password = Get-Content 'C:\mysecurestring.txt' | ConvertTo-SecureString
$cred = new-object -typename System.Management.Automation.PSCredential `
         -argumentlist $username, $password
$subja | Hostname
$subj = 'Automated message:', $subja, ' - Back Online!'
$body = 'Automated message:', $subja, ' has completed the scheduled reboot, and is now back online.'
    Send-MailMessage -smtpServer smtp.office365.com -Port 587 `
        -Credential $cred `
        -Encoding UTF8 `
        -UseSsl `
        -from '$username' `
        -to @('<toAddresses>') `
        -subject "$subj" `
        -body "$body" `
        -ErrorAction Stop