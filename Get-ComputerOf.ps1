function Get-ComputerOf { param([string]$start)
$name = $start + "*"
Get-ADComputer -Filter * -Properties Description | Where-Object {$_.Description -like "$name"} | Select-Object Name, Description
}
