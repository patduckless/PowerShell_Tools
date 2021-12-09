#
if (Test-Connection -ComputerName SMTP.record.local -Count 1 -TimeToLive 15) {
$null = powercfg /batteryreport /output ".\battery-report.html"
$Report = get-content ".\battery-report.html" -ErrorAction Stop 
Remove-Item ".\battery-report.html"
$hostname = Hostname
$search = "Installed batteries"
$linenumber = $Report | select-string $search
$DesCap = ($linenumber.LineNumber) + 9
$DesCap = ($Report.Get($DesCap)).Remove(0, (($Report.Get($DesCap).Length - 10)))
$DesCap = [int]($DesCap.replace(" mWh", "")).Replace(",", "")
$Cap = ($linenumber.LineNumber) + 11
$Cap = ($Report.Get($Cap)).Remove(0, (($Report.Get($Cap).Length - 10)))
$Cap = [int]($Cap.replace(" mWh", "")).Replace(",", "")

$BatteryHealth = [math]::Round(($Cap/$DesCap * 100),2)
Out-Host -InputObject ("Battery is at " + $BatteryHealth + "% of original design capacity.`nDesign Capacity: " + $DesCap + " mWh`nCurrent Capacity: "+ $Cap + " mWh")

$Date = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd HH:mm:ss")

$JSONData = @{Hostname="$hostname";DesignCapacity="$DesCap";CurrentCapacity="$Cap";Timestamp="$Date"} | ConvertTo-Json -Compress

Out-File -FilePath .\BatteryHealth.JSON -InputObject $JSONData 
Send-MailMessage -Attachments .\BatteryHealth.JSON -To <email for notification> -Subject "$hostname - BatteryHealth" -Body "Please find attached JSON formatted data for the bettery health of $hostname." -From "$hostname@$ENV:HOSTNAME" -SmtpServer <SMTP_RELAY>
Remove-Item .\BatteryHealth.JSON
}