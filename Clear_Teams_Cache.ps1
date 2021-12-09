$challenge = Read-Host "Are you sure you want to delete Teams Cache (Y/N)?"
$challenge = $challenge.ToUpper()
if ($challenge -eq "N"){
Stop-Process -Id $PID
}elseif ($challenge -eq "Y"){
Write-Host "Stopping Teams Process" -ForegroundColor Yellow
try{
Get-Process -ProcessName Teams | Stop-Process -Force
Start-Sleep -Seconds 3
Write-Host "Teams Process Sucessfully Stopped" -ForegroundColor Green
}catch{
Write-Outpute-Output $_
}
Write-Host "Clearing Teams Disk Cache" -ForegroundColor Yellow
try{
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\application cache\cache" | Remove-Item -Confirm:$false
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\blob_storage" | Remove-Item -Confirm:$false
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\databases" | Remove-Item -Confirm:$false
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\cache" | Remove-Item -Confirm:$false
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\gpucache" | Remove-Item -Confirm:$false
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\Indexeddb" | Remove-Item -Confirm:$false
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\Local Storage" | Remove-Item -Confirm:$false
Get-ChildItem -Path $env:APPDATA\"Microsoft\teams\tmp" | Remove-Item -Confirm:$false
Write-Host "Teams Disk Cache Cleaned" -ForegroundColor Green
}catch{
Write-Outpute-Output $_
}
<#
Write-Host "Stopping Chrome Process" -ForegroundColor Yellow
try{
Get-Process -ProcessName Chrome| Stop-Process -Force
Start-Sleep -Seconds 3
Write-Host "Chrome Process Sucessfully Stopped" -ForegroundColor Green
}catch{
Write-Output $_
}
Write-Host "Clearing Chrome Cache" -ForegroundColor Yellow
try{
Get-ChildItem -Path $env:LOCALAPPDATA"\Google\Chrome\User Data\Default\Cache" | Remove-Item -Confirm:$false
Get-ChildItem -Path $env:LOCALAPPDATA"\Google\Chrome\User Data\Default\Cookies" -File | Remove-Item -Confirm:$false
Get-ChildItem -Path $env:LOCALAPPDATA"\Google\Chrome\User Data\Default\Web Data" -File | Remove-Item -Confirm:$false
Write-Host "Chrome Cleaned" -ForegroundColor Green
}catch{
Write-Output $_
}
#>
Write-Host "Stopping IE Process" -ForegroundColor Yellow
try{
Get-Process -ProcessName MicrosoftEdge | Stop-Process -Force
Get-Process -ProcessName IExplore | Stop-Process -Force
Write-Host "Internet Explorer and Edge Processes Sucessfully Stopped" -ForegroundColor Green
}catch{
Write-Output $_
}
Write-Host "Clearing IE Cache" -ForegroundColor Yellow
try{
RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 8
RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 2
Write-Host "IE and Edge Cleaned" -ForegroundColor Green
}catch{
Write-Output $_
}
Write-Host "Cleanup Complete... Launching Teams" -ForegroundColor Green
Start-Process -FilePath $env:LOCALAPPDATA\Microsoft\Teams\current\Teams.exe
Stop-Process -Id $PID
}else{
Stop-Process -Id $PID
}