$KBtoRemove = "Package_for_RollupFix~31bf3856ad364e35~amd64~~18362.1440.1.7", "Package_for_RollupFix~31bf3856ad364e35~amd64~~18362.1440.1.7"
$comps = Get-ADComputer -SearchBase "<SB>" -Filter *
foreach ($comp in $comps)
{
    Invoke-Command -AsJob -ComputerName $Comp.DNSHostName -ScriptBlock {
        $env:COMPUTERNAME
        foreach ($KB in $KBtoRemove)
        {
            $SearchUpdates = dism /online /get-packages | findstr "Package_for"
            $updates = $SearchUpdates.replace("Package Identity : ", "") | findstr "Package_for_RollupFix~31bf3856ad364e35~amd64~~18362.1440.1.7"
            #$updates
            DISM.exe /Online /Remove-Package /PackageName:$updates /quiet /norestart
        }
        wmic qfe list brief /format:table
    }
}