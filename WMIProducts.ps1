Cscript.exe .\WMIProducts.vbs

$installer = get-childitem c:\Windows\Installer\*.msi, c:\Windows\Installer\*.msp
Out-File "Working.txt" -InputObject "GUID,Name,Path"
Add-Content -Path ".\Working.txt" -Value ((get-content ".\products.txt").Replace("||| ", ","))
Add-Content -Path ".\Working.txt" -Value ((get-content ".\patches.txt").Replace("||| ", ","))
$programs = import-csv .\Working.txt
foreach ($Item in $installer) {
    if(!(($programs.Path).Replace("C:\WINDOWS\Installer\", "") -match $Item.Name)){ 
        $Item | Remove-Item -WhatIf
    }
}

# Cleanup
Get-Item "products.txt", "Working.txt", "patches.txt" | Remove-Item