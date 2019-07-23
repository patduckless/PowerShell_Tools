$path = '\\?\<filePath>'
$share = Get-ChildItem -LiteralPath $path -Recurse -Filter "*.lnk" | Where { $_.PsIsContainer -eq $False }
$share |  Remove-Item -ErrorAction SilentlyContinue -WhatIf
