$AutoUpdates = New-Object -ComObject "Microsoft.Update.AutoUpdate"
$AutoUpdates.DetectNow()
$AutoUpdates.Results()
USOCLIENT ScanInstallWait 
