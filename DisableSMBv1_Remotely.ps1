$List = <sERVERS WITH smb V1>

ForEach ($Comp in $List)
{
    Invoke-Command -asjob -ComputerName $Comp -ScriptBlock {
        if ((Get-WindowsOptionalFeature -Online -FeatureName smb1protocol).State -eq "Enabled" ) { Disable-WindowsOptionalFeature -Online -FeatureName smb1protocol -NoRestart }
    }
}