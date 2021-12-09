function Get-ScheduledTaskUsers
{
    ## Set script parameter
    param(
        [parameter(Mandatory = $true)]
        [String]$CompList,
        [parameter(Mandatory = $false)]
        [String[]]$RunAsAccount,
        [parameter(Mandatory = $true)]
        [String]$ExportLocation,
        [Parameter(Mandatory = $true)]
        [PSCredential]$Credential
    )
    ## Get list of device to check
    $comps = Get-Content $CompList
    ## Loop through each device
    foreach ($comp in $comps)
    {
        Write-Host "Testing connection to $($comp)" -ForegroundColor DarkGreen
        $TC = Test-Connection $comp -Count 1 -ErrorAction SilentlyContinue
        if ($TC)
        {
            Write-Host "Checking $($comp)" -ForegroundColor Green
            ## Check scheduled task for specified run as account
            if ($null -ne $RunAsAccount)
            {
                $schtask = Invoke-Command -Credential $Credential -ComputerName $comp -ArgumentList $RunAsAccount -ScriptBlock {
                    schtasks.exe /query /V /FO CSV | ConvertFrom-Csv | Select-Object HostName, TaskName, Status, "Next Run Time", "Run As User" |
                    Where-Object { $_."Run As User" -contains $RunAsAccount } }
            }
            else
            {
                $schtask = Invoke-Command -Credential $Credential -ComputerName $comp -ArgumentList $RunAsAccount -ScriptBlock {
                    schtasks.exe /query /V /FO CSV | ConvertFrom-Csv | Select-Object HostName, TaskName, Status, "Next Run Time", "Run As User" }
            }
            if ($schtask)
            {
                ## Export results
                Write-Host "Task found exporting to results to $($ExportLocation)"
                $schtask | Export-Excel "$ExportLocation\ScheduledTaskExport.xlsx"
            }
            else
            {
                Write-Host "No task found with run as account"
            }
        }
        else
        {
            Write-Host "$($comp) not responding Exporting failures to log file located in $($ExportLocation)" -ForegroundColor Yellow
            $comp | Out-File "$ExportLocation\FailureReport.log" -NoTypeInformation -Append
        }
    }
}