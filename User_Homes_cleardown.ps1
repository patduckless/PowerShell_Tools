<#
Scope: This script is to remove the 'Profile Path' folder for any account that is removed from Active directory.
It will first delete the ones itentified on the previous run as being removed from AD.
Then it will remove the old version of the deletion CSV. 
Finally it scans the User Homes share, and compares it to AD samAccountNames. Placing any folders without a
corrisponding AD account onto the CSV list for deltion next run. 
#>

#Designate the location the CSV is to be stored for a month
$CSVPath = "C:\Users\%username%\Documents\profilePath_to_Remove.csv"

#Gather data from CSV
$removals =  Get-Content -Path $CSVPath 

#Get item object for each folder identified on the list and remove it and it's contents
foreach ($File in $removals) 
{
    Get-Item -Path "<profilePath>" | Remove-Item -Recurse -Force -Whatif
}

#Delete the list CSV used above
Remove-Item -Path $CSVPath 
$Folders = get-item -path "<profilePath>"

#Generate the new list corrisponding folders for accounts that dont exsist in AD
foreach ($Folder in $Folders) 
{
        $user = Get-ADUser -Filter {samAccountName -like $Folder.Name}
        if ($user -eq $null) {Out-File -InputObject $Folder.Name -FilePath $CSVPath -Append} 
}