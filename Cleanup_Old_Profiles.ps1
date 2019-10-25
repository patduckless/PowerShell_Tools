$loc = Get-Location
$UserName = $env:UserName
cd HKLM:\
cd "SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"
ls | ForEach-Object{ $Profile=$_.GetValue('ProfileImagePath')
if ($profile -notmatch "administrator|Ctx_StreamingSvc|NetworkService|Localservice|systemprofile|$Username"){
Write-Host "$Profile removed"
Remove-Item $_.PSPath -Recurse -ErrorAction SilentlyContinue
cd C:\
Remove-Item $Profile -Recurse -ErrorAction SilentlyContinue
cd HKLM:\
 }else{ 
 Write-Host "Skipping $Profile" 
 }
}
cd $loc
