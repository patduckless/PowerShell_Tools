Add-PSSnapin VeeamPSSnapin


if ((Get-VBRJob -Name "Daily Backup Production Off-Site Replication").IsScheduleEnabled -eq $False {
    Get-VBRJob -Name "Daily Backup Production Off-Site Replication" | Enable-VBRJob
}