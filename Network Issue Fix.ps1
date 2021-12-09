Set-ItemProperty -Path "HKLM:Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name SecureProtocols -Value 2728
gpupdate /force