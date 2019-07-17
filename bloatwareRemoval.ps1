﻿Start-Job -Name "ProvApp" -ScriptBlock {
function Remove-ProvApp ($ProvApp) {
Get-AppxProvisionedPackage -online | %{if ($_.displayname -match "$ProvApp") {$_ | Remove-AppxProvisionedPackage -AllUsers}}
}
Remove-ProvApp "Microsoft.Office"
Remove-ProvApp "Microsoft.Xbox"
Remove-ProvApp "Microsoft.Zune"
Remove-ProvApp "Linked"
Remove-ProvApp "HPJump"
Remove-ProvApp "Microsoft.OneConnect"
Remove-ProvApp "Microsoft.Skype"
Remove-ProvApp "Microsoft.BingWeather"
Remove-ProvApp "Microsoft.Messaging"
Remove-ProvApp "Microsoft.People"
Remove-ProvApp "Microsoft.Print3D"
Remove-ProvApp "Microsoft.Wallet"
Remove-ProvApp "Microsoft.WindowsFeedbackHub"
Remove-ProvApp "Microsoft.WindowsMaps"
Remove-ProvApp "Microsoft.YourPhone"
Remove-ProvApp "Microsoft.WindowsSoundRecorder"
Remove-ProvApp "Microsoft.Windowscommunicationsapps"
Remove-ProvApp "Microsoft.WindowsOfficeHub"
Remove-ProvApp "Microsoft.MixedReality.Portal"
Remove-ProvApp "C27EB4BA.DropboxOEM"
Remove-ProvApp "DolbyLaboratories.DolbyAccess"
Remove-ProvApp "Amazon.com.Amazon"
Remove-ProvApp "4DF9E0F8.Netflix"
Remove-ProvApp "C27EB4BA.DropboxOEM"  
Remove-ProvApp "7EE7776C.LinkedInforWindows"  
Remove-ProvApp "Microsoft.Office.Desktop"
Remove-ProvApp "king.com.CandyCrushSaga"  
Remove-ProvApp "Microsoft.MinecraftUWP"  
Remove-ProvApp "Microsoft.BingNews"  
Remove-ProvApp "Fitbit.FitbitCoach"    
Remove-ProvApp "Microsoft.Print3D"  
Remove-ProvApp "PricelinePartnerNetwork.Booking.comBigsavingsonhot"  
Remove-ProvApp "Microsoft.ScreenSketch"
Remove-ProvApp "Microsoft.MicrosoftOfficeHub"
Remove-ProvApp "Microsoft.NetworkSpeedTest"
Remove-ProvApp "Microsoft.Office.Sway"
Remove-ProvApp "Microsoft.OfficeLens"
Remove-ProvApp "Microsoft.Whiteboard"
}
Start-Job -Name "AppPack" -ScriptBlock {
function Remove-App ($name) {
Get-AppxPackage | %{if ($_.name -match "$name") {$_ | Remove-AppxPackage -AllUsers}}
}
Remove-App "C27EB4BA.DropboxOEM"
Remove-App "DolbyLaboratories.DolbyAccess"
Remove-App "Amazon.com.Amazon"
Remove-App "4DF9E0F8.Netflix"
Remove-App "C27EB4BA.DropboxOEM"  
Remove-App "7EE7776C.LinkedInforWindows"  
Remove-App "Microsoft.Office.Desktop"  
Remove-App "king.com.CandyCrushSaga"  
Remove-App "Microsoft.MinecraftUWP"  
Remove-App "Microsoft.BingNews"  
Remove-App "Fitbit.FitbitCoach"    
Remove-App "Microsoft.Print3D"  
Remove-App "PricelinePartnerNetwork.Booking.comBigsavingsonhot"  
Remove-App "Microsoft.ScreenSketch"
Remove-App "Microsoft.MicrosoftOfficeHub"
Remove-App "Microsoft.NetworkSpeedTest"
Remove-App "Microsoft.Office.Sway"
Remove-App "Microsoft.OfficeLens"
Remove-App "Microsoft.Whiteboard"
}

exit