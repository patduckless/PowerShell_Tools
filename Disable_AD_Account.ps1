function Test-Cred {
           
    [CmdletBinding()]
    [OutputType([String])] 
       
    Param ( 
        [Parameter( 
            Mandatory = $false, 
            ValueFromPipeLine = $true, 
            ValueFromPipelineByPropertyName = $true
        )] 
        [Alias( 
            'PSCredential'
        )] 
        [ValidateNotNull()] 
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()] 
        $Credentials
    )
    $Domain = $null
    $Root = $null
    $Username = $null
    $Password = $null
      
    If($Credentials -eq $null)
    {
        Try
        {
            $Credentials = Get-Credential "domain\$env:username" -ErrorAction Stop
        }
        Catch
        {
            $ErrorMsg = $_.Exception.Message
            Write-Warning "Failed to validate credentials: $ErrorMsg "
            Pause
            Break
        }
    }
      
    # Checking module
    Try
    {
        # Split username and password
        $Username = $credentials.username
        $Password = $credentials.GetNetworkCredential().password
  
        # Get Domain
        $Root = "LDAP://" + ([ADSI]'').distinguishedName
        $Domain = New-Object System.DirectoryServices.DirectoryEntry($Root,$UserName,$Password)
    }
    Catch
    {
        $_.Exception.Message
        Continue
    }
  
    If(!$domain)
    {
        Write-Warning "Something went wrong"
    }
    Else
    {
        If ($domain.name -ne $null)
        {
            return "Authenticated"
        }
        Else
        {
            return "Not authenticated"
        }
    }
}
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
$Another = "Yes"
$Cred = Get-Credential -Message "Welcome to 'Disable AD User Tool'
Enter your admin account details please!"
$check = $Cred | Test-Cred
If($check -ne "Authenticated") {
    While($check -ne "Authenticated") {
    $Cred = Get-Credential -Message "Credentials incorrect, Please try again.
Did you include the domain?"
    $check = $Cred | Test-Cred
    }
}
While ($Another -eq "Yes") {
    $SAN = [Microsoft.VisualBasic.Interaction]::InputBox("Enter username to be removed:", "Active Directory User Disable Tool", "")
    If(($SAN -like "*admin*") -or ($SAN -like "*ADM*")) {
        [System.Windows.MessageBox]::Show("You can't disable admin accounts from here!",'Active Directory User Disable Tool - Error!', 'OK', 'Error')
        exit
    }
    Move-ADObject -Identity $SAN "OU=Disabled User Accounts,OU=Genius,DC=genius,DC=local" -ErrorAction Stop -ErrorVariable ProcessError;
    
    If ($ProcessError) {
        $spcheck = [System.Windows.MessageBox]::Show("Specified user account name: $SAN
Not found.
Check your spelling.",'Active Directory User Disable Tool - Error!', 'OKCancel', 'Error')
        switch($spcheck) {
        'OK' {
        }
        'Cancel' {
        Exit}
        }
    }
    Else {Set-ADUser -Identity $SAN -Enabled $false}
    $msgBoxInput = [System.Windows.MessageBox]::Show("Would you like to disable another account?",'Active Directory User Disable Tool', 'Yes,No')
        switch  ($msgBoxInput) {
        'Yes' {
        $Another = "Yes"
        }
        'No' {
        Exit
        }
    }
}