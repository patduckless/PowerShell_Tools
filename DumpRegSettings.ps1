$keys = 'HKCU\Software\'

New-Item -Path C:\temp\reg -ItemType "Directory"
$tempFolder = 'C:\temp\reg'
$outputFile = "$ENV:USERPROFILE\Desktop\software.reg"

$keys | % {
  $i++
  & reg export $_ "$tempFolder\$i.reg"
}

'Windows Registry Editor Version 5.00' | Set-Content $outputFile
Get-Content "$tempFolder\*.reg" | ? {
  $_ -ne 'Windows Registry Editor Version 5.00'
} | Add-Content $outputFile

Remove-Item C:\temp\reg -Recurse -Force
