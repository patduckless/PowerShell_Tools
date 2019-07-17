$share = Get-ChildItem '<filePath>' -Recurse | Where { $_.PsIsContainer -eq $False }
$share |  Remove-Item -Include "*.lnk" -ErrorAction SilentlyContinue -WhatIf