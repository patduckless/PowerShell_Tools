$Book  = Import-Csv -Path .\Book2.csv #import list of users an properties change to your file name and path. 
$Book
foreach($user in $Book) {
#create one of the below for each property you wish to update. 
#Don't forget to add it to the set-ADUser command below
$name = $user.("Name")
$number = $user.("MobilePhone")

get-ADUser -filter {Name -like $name} | Set-ADUser -MobilePhone "$number"
get-ADUser -filter {Name -like $name} -Properties * #Return the user profile to confirm update.
}