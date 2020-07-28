<#
Export-InboxRules
Author: Patrick Duckles
Version: 1.0

Scope:
This is the first phase for migrating inbox rules to office 365. It will take all inbox rules for all mailboxes in your exchange tennant and save them in XML format. 
These XML format documents will then be used after the migration of the user accounts to rebuild the rules for each mailbox in the new tennant. 
#>

#If you change this you will need to change it in the Import-InboxRules script too. 
$XmlPath = "C:\XML Rules" 

#Create PoSh session to on prem Exchange
$onprem = Read-Host -Prompt "FQDN for Exchange Server"
$OnPremExchange = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://$onprem/PowerShell/ -Authentication Kerberos -Credential $(Get-Credential -Message "Credentials for on prem Exchange")

Import-PSSession -Session $OnPremExchange
$AllMailboxes = Get-Mailbox -Server $onprem
New-Item -ItemType "directory" -Path $XmlPath -ErrorAction SilentlyContinue
Set-Location $XmlPath
Foreach ($mailbox in $AllMailboxes) {
    $RulesNulled = $NULL
    $email = $mailbox.WindowsEmailAddress
    $path = ".\$email.xml"
    $Rules = Get-InboxRule -Mailbox $email
    foreach ($Rule in $Rules) {
        #Null properties that are not required
        $Rule.PSComputerName = $NULL
        $Rule.Identity = $NULL
        $Rule.RuleIdentity = $NULL
        $Rule.MailboxOwnerId = $NULL
        $Rule.RunspaceId = $NULL
        $Rule.Description = $NULL
        $Rule.Enabled = $NULL
        $Rule.IsValid = $NULL
        $Rule.SupportedByTask = $NULL
        
        #output
        $Rule | ForEach-Object {
            $NonEmptyProperties = $_.psobject.Properties | Where-Object {$_.Value} | Select-Object -ExpandProperty Name
            $_ | Select-Object -Property $NonEmptyProperties | Set-Variable -Name "RuleNoNull"
        }
        $RulesNulled = [Array]$RulesNulled + $RuleNoNull
    }
    Export-Clixml -Path $path -InputObject $RulesNulled

}
Exit-PSSession
Remove-PSSession -Session $OnPremExchange