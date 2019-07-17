$Source = ".\criteria" #This is the location of the files you want to find 
$location = ".\sample" #This is the locaiton you want to find the files in
$Reference = Get-ChildItem -Path $Source
$Difference = Get-ChildItem -Path $location
Compare-Object -ReferenceObject $Reference -DifferenceObject $Difference -Property Name,Length -PassThru -ExcludeDifferent -IncludeEqual | %{
    $Item = $_
    $Item
    $Difference | ?{$_.Name -eq $Item.Name -and $_.Length -eq $Item.Length}
} | Select -ExpandProperty FullName