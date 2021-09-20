$printserver = "<serverName>" 
 Get-CimInstance -ClassName Win32_Printer -computer $printserver | Select Name,DriverName,PortName | Export-CSV -path 'C:\Users\%username%\Desktop\printers.csv'
