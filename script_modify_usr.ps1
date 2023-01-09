# Import the active directory module
Import-Module ActiveDirecctory

# Import the data from the csv file
$usersData = Import-CSV -Path $args[0] -Delimiter ";" -Encoding UTF8



foreach ($user in $usersData) {
    $username =  $user.userName
    $newfirstname =  $user.newFirstName
    $newlastname =  $user.newLastName
    $newusername =  $user.newUserName

    if (Get-ADUser -F { SamAccountName -eq $username }  -SearchBase "OU=utilisateurs,DC=L1-1,DC=lab"){
        # if the user already exists

        Set-ADAcount -Identity $username -SAMAccountName $newusername -GivenName $newfirstname -Surname $newlastname
        Write-output("This user ($username) has been updated.")
    }
    else{
        # if the user does not exist 
        
        Write-Warning "User $username does not exist !"
        
    }
}