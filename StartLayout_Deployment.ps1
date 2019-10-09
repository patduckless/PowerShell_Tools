#Run this on the machine you have setup the start menu.
Export-StartLayout -Path .\StartLayout.xml

#Copy .\StartLayout.xml to your UNC Share Path.

#Run this on any machine you wish to have the start layout on.
Start-Job -Name "StartLayout" -ScriptBlock {
copy '\\<UNC PATH TO SHARE>\StartLayout.xml' C:\
	Import-StartLayout -LayoutPath C:\StartLayout.xml -MountPath C:\ 
RM C:\StartLayout.xml
}
