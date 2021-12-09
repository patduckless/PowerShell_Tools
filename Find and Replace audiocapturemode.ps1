$RDPProfs = Get-ChildItem -Filter {*.rdp} -Recurse | ? {$_.LastWriteTime -gt (Get-Date).AddDays(-90)}
foreach ($profile in $RDPProfs) {
((Get-Content -path $profile.PSpath ) -replace 'audiocapturemode:i:0','audiocapturemode:i:1') | Set-Content -Path $profile.PSpath
}