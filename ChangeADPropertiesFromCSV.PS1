$csv  = Import-Csv -Path .\<list>.csv #import list of users an properties. change to your file name and path. 
$csv
foreach($user in $csv) {

#Create one of the below for each property you wish to update. 

$name = $user.("Name")
$number = $user.("Number")

$ADUser = get-ADUser -filter {Name -like $name} -Properties * #Get the User account

#Set the properties you wish to change shere in teh format $ADUser.<property you wish to change>
$ADUser.MobilePhone = $number

Set-ADUser -Instance $ADUser

$ADUser = get-ADUser -filter {Name -like $name} -Properties MobilePhone

Out-host -InputObject $ADUser #Return the user profile to confirm update.
}
