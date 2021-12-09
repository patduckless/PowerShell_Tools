$Hidden = Get-DistributionGroup -identity "TEST"

$HiddenGroupVars = @()

foreach ($Group in $Hidden) {
    $members = $NULL
    $GroupName = $Group.Name
    $members = Get-DistributionGroupMember -Identity $GroupName
    New-Variable -Name $Group.Name -Value $members
    $HiddenGroupVars += $Group.Name
}

Get-PSSession | Remove-pssession

Connect-ExchangeOnline

foreach($Variable in $HiddenGroupVars){
    $Name = Get-Variable -Name $Variable
    $Group = ( $Hidden | Where-Object -Property Name -eq $Name.Name )
    $GroupMembers = @((Get-Variable -Name $Group).Value.PrimarySmtpAddress.Replace(" ", ", "))
    $X500 = "X500:" + $Group.legacyExchangeDN
    $New = @{
        MemberJoinRestriction = $Group.MemberJoinRestriction
        MemberDepartRestriction = $Group.MemberDepartRestriction
        Alias = $Group.Alias
        DisplayName = $Group.DisplayName
        PrimarySmtpAddress = $Group.PrimarySmtpAddress
        SendModerationNotifications = $Group.SendModerationNotifications
        Name = $Group.Name
    }
    if(!($Group.RequireSenderAuthenticationEnabled -eq $Null)){
        $New += @{RequireSenderAuthenticationEnabled = $true}
    }
    Out-Host -inputObject ("Creating: " + $Group.PrimarySmtpAddress)
    New-DistributionGroup @New -whatif
    if($Group.ModerationEnabled -eq $true){
        Out-Host -inputObject "Moderation will need to be enabled manualy! `n" 
        pause
    }
    Out-Host -inputObject "Done! `nAdding X500 address."
    Set-DistributionGroup -identity $Group.Name -EmailAddresses @{Add = $X500} -whatif
    Out-Host -inputObject "Done!"
    if($Group.HiddenFromAddressListsEnabled -eq $true){
        Out-Host -inputObject "Hiding from address list."
        Set-DistributionGroup -identity $Group.Name -HiddenFromAddressListsEnabled $true -whatif
        Out-Host -inputObject "Done!"
    }
    Out-Host -inputObject "Adding members."
    $GroupMembers | Foreach{ Add-DistributionGroupMember -Identity $Group.Name -Member $_ -whatif }
    Out-Host -inputObject ($Group.Name + ": Configured!")
}