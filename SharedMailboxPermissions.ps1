$MlBxPrmsns = get-Mailbox -Filter {Name -like "some name"} | foreach{ Get-MailboxPermission $_.UserPrincipalName }
$MlBxPrmsnsArray = @()
$MlBxPrmsns | Foreach{ 
    $access = $_.AccessRights.Split(",").Replace(" ","") | Sort

    $box = New-Object PSObject
    $box | Add-Member -MemberType NoteProperty -Name Identity -Value $null
    $box | Add-Member -MemberType NoteProperty -Name User -Value $null
    $box | Add-Member -MemberType NoteProperty -Name FullAccess -Value $null
    $box | Add-Member -MemberType NoteProperty -Name DeleteItem -Value $null
    $box | Add-Member -MemberType NoteProperty -Name ReadPermission -Value $null
    $box | Add-Member -MemberType NoteProperty -Name ChangePermission -Value $null
    $box | Add-Member -MemberType NoteProperty -Name ChangeOwner -Value $null
    $box | Add-Member -MemberType NoteProperty -Name ExternalAccount -Value $null
    $box | Add-Member -MemberType NoteProperty -Name SendAs -Value $null

    $box.Identity = $_.Identity
    $box.User = $_.User

    foreach($item in $access){
        $box.$Item = $true
    }
    $MlBxPrmsnsArray += $box
}

$MlBxPrmsnsArray | Export-Excel 