# Let's use CimInstance instead, WmiObject is getting depreciated
$mysid = Get-CimInstance Win32_UserAccount -Filter "name='$($env:USERNAME)'" | Select -ExpandProperty sid
$HKs = Get-ChildItem -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\Creative\$mySid | Get-ItemProperty -Name LandscapeImage 
$LandscapeImageLoc = $HKs | select -ExpandProperty LandscapeImage

$DestinationPath = "c:\users\$env:USERNAME\WallPapers"
# Make sure destination path exists
If (-not (Test-Path -Path $DestinationPath))
{
    $null = New-Item -Path $DestinationPath -ItemType Directory
}

ForEach ($Image in $LandscapeImageLoc)
{
    # Pull just the file name
    $FileName = Split-Path -Path $Image -Leaf

    # Create full destination path and add .jpg to the end of the filename
    $Destination = Join-Path -Path $DestinationPath -ChildPath "$FileName.jpg"

    # Perform the copy
    Copy-Item -Path $Image -Destination $Destination
}