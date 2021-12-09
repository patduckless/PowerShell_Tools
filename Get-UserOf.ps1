function Get-UserOf { param([string]$Name) 
$return = Get-ADComputer -Filter {Name -like $Name} -Properties Description | Select Description
$return
}
