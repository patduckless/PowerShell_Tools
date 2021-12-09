$users = Get-aduser -filter * -properties sidhistory | Where sidhistory

foreach ($us in $users){

    write-host "Removing SidHistory of user $us"
    Get-ADUser -Identity $us -Properties SidHistory | Select-Object -ExpandProperty SIDHistory | Select-Object -ExpandProperty Value | % {Set-ADUser -Identity $us -Remove @{SIDHistory="$_"}}

}