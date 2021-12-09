Function Update ([string]$PCName) {
    Invoke-Command -ComputerName $PCName -ScriptBlock {
        Out-Host -InputObject ("Updating $PCName" + "...")
        Start-Service usosvc
        USOCLIENT /ScanInstallWait
	USOCLIENT /StartInstall
        USOCLIENT ScanInstallWait
	USOCLIENT StartInstall
        Out-Host -InputObject ("Done!")
    }}