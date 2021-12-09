Start-Sleep 500
$wshell = New-Object -ComObject wscript.shell
$a = Start-Process <path> -ArgumentList <ARGS> -PassThru
Start-Sleep 30
$wshell.AppActivate($a.MainWindowTitle)
$wshell.SendKeys(<this can be used to send keystrokes to the window>)
Start-Sleep 30 
$wshell.SendKeys("{ENTER}")