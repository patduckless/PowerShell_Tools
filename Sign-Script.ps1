function Sign-Script {
param([string]$Path)
$acert =(dir Cert:\CurrentUser\My -CodeSigningCert)[0]
if (!$Path) {$Path = Read-Host -Prompt Path}
Set-AuthenticodeSignature "$Path" -Certificate $acert -IfError 
}