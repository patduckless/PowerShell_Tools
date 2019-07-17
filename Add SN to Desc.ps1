<#
Script to retrieve serial number and add it to the description of the computer running. this is to be set to run at logon for
all computers. 
#>

Import-Module ActiveDirectory #This is to add cmdlets required for script
$hostname = Hostname #defines device hostname variable
Get-ADComputer $hostname -Properties Description | #retrieves device AD object with description
ForEach-Object {
$SN = Get-WmiObject -Class Win32_bios | Select-Object -ExpandProperty serialNumber #get serial number from bios
Set-ADComputer $_ -Description "SerialNumber: $SN $($_.Description)" #sets description to be serialnumber + current Description 
}
$hostname = ($hostname+'$') #add $ to end of $hostname variable to make it SAM account name
Remove-ADGroupMember -Identity SerialNumber -Members $hostname <#remove computer from SerialNumber group this is to prevent 
script from running every boot cycle. script can only be run by members of the SerialNumber Group. #>
Remove-Module ActiveDirectory #Remove cmdlts for script 