$listedComputers = Import-Excel .\list.xlsx
$me = Get-Credential
Foreach ($comp in $listedComputers) { if ($comp.Status -eq "Failed"){
    Invoke-Command $comp.name -Credential $me -AsJob -ScriptBlock {
        $lUser = get-localuser | Where-Object -Property enabled -Value "True" -EQ | Where-Object -Property Name -NE -Value "Administrator"
        $lUser | remove-localUser
    } } }

While((get-job).State -eq "Running"){Wait}
Get-Job | Receive-Job | Export-Excel