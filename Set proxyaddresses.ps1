$list = import-csv -path XXXXX

foreach($user in $list){
    $proxy = $user.ProxyAddresses
    Set-ADUser -identity $user.SamAccountName -add @{ProxyAddresses="$proxy"}
}