# Import speech synthesis tools
Add-Type -AssemblyName System.speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$username = ($env:UserName).Split("{ }")[0]
function Start-SleepUntil($future_time) { 
    if ([String]$future_time -as [DateTime]) { 
        if ($(get-date $future_time) -gt $(get-date)) { 
            $sec = [system.math]::ceiling($($(get-date $future_time) - $(get-date)).totalseconds) 
            start-sleep -seconds $sec 
        } 
        else {  
            return 
        } 
    } 
}

$moveReq = Get-MoveRequest
$ONPREM = Read-Host "Enter your Exchange URL"
# Infinite Loop
While($true) {
    # Null all variables used in loop
    $neCompl = $null
    $AutoSus = 0

    $now = ((Get-Date).AddMinutes(1).ToShortTimeString())

    # Get Move requests that are not completed
    $neCompl = $moveReq | where-Object {($_.RemoteHostName -eq $ONPREM) -and ($_.Status -ne "Completed")} | where-Object{$_.Status -ne "CompletedWithWarning"} | Get-MoveRequestStatistics

    # Output time each loop to allow user to see log. Useful for using in conjuntion with Stat-Transcript

    Out-Host -inputobject ("`n" + (Get-Date).ToShortTimeString())
    $neCompl | Format-Table DisplayName, StatusDetail, TotalMailboxSize, PercentComplete

    # Tell user about auto suspened 
    foreach($job in $neCompl){
        If($job.StatusDetail.Value -eq "AutoSuspended") {
            $AutoSus = $AutoSus + 1}
    } 

    # Inform user if all jobs are suspended and exit loop
    $inProg = $neCompl.Count
    if($Null -eq $inProg){$inProg = 1}
    if($AutoSus -eq $inProg)  {
        $speak.Speak("$Username, Office 365 move request requires attention")
        break
    }

    # If there are only completed requests let the user know and exit the infinite loop
    if($null -eq $neCompl) { 
        $speak.Speak("$Username, Office 365 move request requires attention")
        break
    }

    Out-Host -InputObject "Suspended: $AutoSus
InProgress: $inProg"
    # Pause the loop for 1 minute. 
    Start-SleepUntil $now
}
