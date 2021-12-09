$remhost = read-host "Enter name of computer having issues"
invoke-command -computername $remhost -scriptblock {
$GPSVC = (Get-CimInstance Win32_Service | where { $_.Name -eq 'gpsvc' }).processID
Stop-Process -ID "$GPSVC" -Force -Confirm:$false
gpupdate /target:computer
}