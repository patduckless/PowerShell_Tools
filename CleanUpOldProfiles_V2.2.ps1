<#
Removes local profiles other than running user and service accounts. 

Version: 2.2
Author: Patrick Duckles
#>

$UserName = $env:UserName
$keeplist = "administrator|Ctx_StreamingSvc|NetworkService|Localservice|systemprofile|$Username|SYSTEM"
$date = (Get-Date).AddDays(-182.5)

$localProfiles = Get-CimInstance -Class Win32_UserProfile 

foreach ($Profile in $localProfiles) {
    $name = $Profile.LocalPath.split('\')[-1]
    if ((Get-Item $Profile.LocalPath).LastWriteTime -gt $date) {
        Write-Host "Skipping: $name"
        Continue
    }
    if ($name -notmatch $keeplist){
        
        Write-Host "`n`nRemoving: $name" -ForegroundColor Yellow
        Get-CimInstance $profile | Remove-CimInstance -Confirm
    }
    else{ 
        Write-Host "Skipping: $name" 
    }
}
if (!($psISE)){"Press any key to continue...";[void][System.Console]::ReadKey($true)}
