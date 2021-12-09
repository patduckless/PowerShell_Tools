## deprecated as pswindowsupdate module exisits


Function Invoke-RemoteUpdate{

#A command to scan for and install Windows updates on a remote system. 

Param(
[parameter(position=0)]
$ComputerName,
[parameter(position=1)]
$Credential
)

if ($ComputerName -eq $NULL){
$ComputerName = Read-Host -Prompt "Input hostname for update target"
}

$isup = Test-Connection -ComputerName $ComputerName -Count 1 -ErrorAction SilentlyContinue
if ($isup -eq $NULL) {Out-Host -InputObject "$ComputerName is not avalible. Either the name is incorrect or the host is offline."}

if ($isup -ne $NULL) {
if ($Credential.username -eq $NULL -or $Credential -eq $NULL){ $credential = Get-Credential -Credential $Credential }

try {
$S1 = New-PSSession -ComputerName $ComputerName -Credential $credential -ErrorAction Stop

Invoke-Command -Session $S1 -ScriptBlock { UsoClient.exe } -ArgumentList ScanInstallWait
Invoke-Command -Session $S1 -ScriptBlock { UsoClient.exe } -ArgumentList StartInstall

Remove-PSSession -Session $S1 -ErrorAction SilentlyContinue
Out-Host -InputObject "$ComputerName is updating"
}
catch {

Write-Host "Username or Password incorrect."

}}}
