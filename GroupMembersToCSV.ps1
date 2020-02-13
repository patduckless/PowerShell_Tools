Import-Module -Name ActiveDirectory

$Groups = Get-ADGroup -Filter * -SearchBase "OU=India,OU=MiddleEast-India,OU=Production,DC=ad,DC=fugro,DC=com"

$Report = foreach ($Group in $Groups) {

$Members = Get-ADGroupMember -Identity $Group
$Members = $Members.Name
foreach ($M in $Members) { $Mout = $Mout + ", " + $M }
$output = $Group.Name + ", " + $Mout
out-file -InputObject $output -FilePath D:\GroupMembers1.csv -Append
}
