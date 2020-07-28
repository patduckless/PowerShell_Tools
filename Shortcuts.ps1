# Provide UNC path to share you wish to scan and clean up.
$path = '\\<server name>\<filePath>'
$share = Get-ChildItem -LiteralPath $path -Recurse -Filter "*.lnk" | Where { $_.PsIsContainer -eq $False }
# Remove the WhatIf parameter to actually remove the files, otherwise this will just list them.
$share |  Remove-Item -ErrorAction SilentlyContinue -WhatIf
