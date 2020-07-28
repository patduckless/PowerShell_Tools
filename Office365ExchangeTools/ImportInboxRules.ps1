#Create PoSh session to O365 Exhcange
$O365Exchange = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential (Get-Credential -message "Enter Office 365 Credentials...") -Authentication Basic -AllowRedirection

Import-PSSession $O365Exchange
#Part 3: Import XML data back in for use
Set-Location "C:\XML Rules"
$XMLItems = Get-ChildItem
foreach($Rule in $XMLItems){
    $Email = [String]$Rule.Name -replace (".xml")
    $RulesPoSh = Import-CLIXML -Path $Rule
    foreach($PSRule in $RulesPoSh) {
        #Clear RuleHash Table 
        $RuleHash = $NULL
        #Extract properties from rule.      
        $RuleProp = $PSRule.psobject.Properties
        #Convert properties into a hash table
        $RuleProp | foreach-object { $RuleHash = $RuleHash + @{$_.Name = $_.Value} }
        #Create new rule based on hash table. 
        New-InboxRule @RuleHash -Mailbox $Email -Whatif
    }
}
Get-PSSession | Remove-PSSession