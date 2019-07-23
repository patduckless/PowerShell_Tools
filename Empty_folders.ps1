$share = Get-ChildItem '<path>' -Recurse -Filter "New Folder*" | Where { $_.PsIsContainer -eq $true }
$share | Where { $_.GetFiles().Count -eq 0 -and $_.GetDirectories().Count -eq 0 } | Remove-Item -ErrorAction SilentlyContinue
