$source = <source>
$dest = "C:\ESM"

$files = Get-ChildItem -Path $source -Exclude Archived,local

Foreach($item in $files) {
    $path = $dest + "\" + $item.Name
    if(!(Get-Item -Path $path -ErrorAction SilentlyContinue)){ copy-Item $item -Destination $dest }
}

$exsync = Get-Process ExSync -ErrorAction SilentlyContinue
if (!($exsync)){ Start-Process -FilePath C:\ESM\ExSync.exe }