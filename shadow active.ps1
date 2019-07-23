$Path = <path>
$today = Get-Date
$share = Get-ChildItem -LiteralPath $Path -Recurse -Hidden | Where { $_.PsIsContainer -eq $False }
$share |  Remove-Item -Exclude "Thumbs.db" -ErrorAction SilentlyContinue -WhatIf | Where { $_.LastWriteTime -lt $today }
