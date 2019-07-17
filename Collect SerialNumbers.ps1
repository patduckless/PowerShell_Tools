Import-csv C:\Users\%username%\Documents\Computer_names.csv | `
ForEach-Object{out-host -inputobject $_.H1
get-ciminstance -classname win32_bios -computername $_.H1 | format-list serialnumber | out-host}