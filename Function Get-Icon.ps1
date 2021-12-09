Function Get-Icon
{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True, HelpMessage = ”Enter the location of the .EXE file”)]
        [string]$folder
    )
    [System.Reflection.Assembly]::LoadWithPartialName(‘System.Drawing’)  | Out-Null
    mkdir $folder -ea 0 | Out-Null
    Get-ChildItem $folder *.exe -ea 0 -rec |
    ForEach-Object {
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($_.FullName)
        Write-Progress “Extracting Icon” $basename
        [System.Drawing.Icon]::ExtractAssociatedIcon($_.FullName).ToBitmap().Save(“$folder$basename.ico”)
    }
}