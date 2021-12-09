$servers = Get-ADComputer -Filter {enabled -eq "true" -and OperatingSystem -Like '*Windows Server*' }
foreach($Server in $servers){ 
    else{
    $Output = Invoke-Command -ScriptBlock  {Get-WmiObject win32_service} -ComputerName $Server.DNSHostName
    Export-Excel -InputObject $Output -Path .\ServiceAccounts.xlsx -Append
    }
}