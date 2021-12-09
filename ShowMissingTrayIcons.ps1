cd "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify"
rm IconStreams
rm PastIconStreams
Stop-Process -ProcessName explorer