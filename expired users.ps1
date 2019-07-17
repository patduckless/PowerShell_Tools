$Path = "Last_Logon.csv"
Get-ADUser -Filter {enabled -eq $true} -Properties LastLogonTimeStamp | `
Select-Object Name, SAMAccountName, @{Name="Last Sucessful Logon"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp).ToString('yyyy-MM-dd_hh:mm:ss')}} | `
Export-Csv -Path $Path –notypeinformation
$location = Get-Location
$location = 'Last Logon time exported to: ' + "$location" + 'Last_Logon.csv'
Out-Host -inputobject "$location"