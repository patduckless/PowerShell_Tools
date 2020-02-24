#This Script should be signed with a trusted code signing certifiacte. 
#you can use the funtion here: https://github.com/patduckless/PowerShell_Tools/blob/master/Sign-Script.ps1
#It will require a Codesigning certificate from your cert authority.
#
#It is designed to run a program as another user without giving out their credentials i.e. admin.
#for the password you will need to run: https://github.com/patduckless/PowerShell_Tools/blob/master/SecureStringGenerator.ps1
#I would reccomend setting up a new local administrative user just to run this. 
#
#Set-ExecutionPolicy -ExecutionPolicy AllSigned to prevent exploitation of your system
#
#Change anything in <> with the contents.
#


username = "<userName>" # Set username for mailserver
$password = Get-Content '<path>' | ConvertTo-SecureString # Import the secured password
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password
Start-Process -FilePath "<path to .EXE>" -Credential $cred 

