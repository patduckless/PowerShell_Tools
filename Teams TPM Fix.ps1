$cred = Get-Credential -Message "Please provide your admin credentials"
$user = ($ENV:LOCALAPPDATA).ToString()
Invoke-Command -Credential $cred -ArgumentList $user -ComputerName $ENV:COMPUTERNAME -ScriptBlock {
    Get-Process -Name Teams | Stop-Process -Force
    set-acl -path C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc -AclObject (Get-ACL -Path $ENV:USERPROFILE) -Confirm:$FALSE 
    Get-ChildItem -Path C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Ngc | Remove-Item -Force -Recurse
    Remove-Item -Path $user\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy -Recurse -Force
}
New-ItemProperty -Path "HKCU:\Software\Microsoft\Office\16.0\Common\Identity" -Name EnableADAL -PropertyType Dword -Value 0 