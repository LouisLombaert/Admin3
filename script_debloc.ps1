# Import the active directory module
Import-Module ActiveDirecctory

# Import the data from the csv file
$usersData = Import-CSV -Path $args[0] -Delimiter ";" -Encoding UTF8


foreach ($user in $usersData) {
    $username =  $user.userName

    if (Get-ADUser -F { SamAccountName -eq $username } -SearchBase "OU=utilisateurs,DC=L1-1,DC=lab"){ #specifies the name and the AD path
        # if the user exists

        Unlock-ADAcount -Identity $username
        Write-output("This user's account ($username) has been unlocked.")
    }
    else{
        # if the user does not exist
        
        Write-Warning "User $username does not exist !"
        
    }
}