$OnPremExchange = Read-Host "External facing URL of your Exchange server"
$TargetDomain = Read-Host "URL of your Office 365 server"
$ONPREMCREDS = Get-Credential -Message "Credentials for Local Exchange"

# Import Data to be used
$next = Import-Csv -Path .\Next.csv
foreach($item in $next) {
    # Get the users ad account
    $user = (Get-ADUser -Identity $item.DisplayName -Properties UserPrincipalName).UserPrincipalName
    #Create teh move request for the user
    New-MoveRequest -Identity ($user) -Remote -RemoteHostName $OnPremExchange -TargetDeliveryDomain $TargetDomain -RemoteCredential $ONPREMCREDS -BadItemLimit 5 -SuspendWhenReadyToComplete:$true
}

.\WatchMoveToOffice365.ps1
