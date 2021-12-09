$skype = Get-Process -Name "Skype" -ErrorAction SilentlyContinue
if ($null -ne $skype) {Stop-Process $skype}
$outlook = Get-Process -Name "outlook" -ErrorAction SilentlyContinue
if ($null -ne $outlook) {Stop-Process $outlook}

$username = [Environment]::UserName
Set-Location "C:\Users\$username\AppData\Local\Microsoft\Outlook\"
Get-ChildItem | Where-Object Name -like ("*.ost") | Remove-Item -Force -Confirm:$false

Set-Location hkcu:\Software\Microsoft\Office\16.0\Outlook\Profiles\

get-childitem | Remove-Item -Recurse

Get-ControlPanelItem *mail* | Show-ControlPanelItem
Start-Process outlook.exe