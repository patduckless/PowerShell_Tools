$list = Get-ADGroup -SearchBase "SB" -Filter *

foreach($obj in $list){
    $name = $obj.Name -replace "SM "
    $memberlist = Get-ADgroupMember -Identity $obj.Name

    foreach($member in $memberlist){
        Add-ADPermission -Identity $name -User $member.SamAccountName -AccessRights ExtendedRight -ExtendedRights "Send As"
    }        
}