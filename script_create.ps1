# Import the active directory module
Import-Module ActiveDirecctory

# Import the data from the csv file
$usersData = Import-CSV -Path $args[0] -Delimiter ";" -Encoding UTF8


foreach ($user in $usersData) {
    $username =  $user.userName
    $firstname =  $user.firstName
    $lastname =  $user.lastName
    $password =  $user.password

    if (Get-ADUser -F { SamAccountName -eq $username }){
        # if the user already exists

        Write-Warning "This user ($username) already exist !"
    }
    else{
        # if the user does not exist 

        New-ADUser `
            -Name "$firstname $lastname" `
            -GivenName $firstname `
            -Surname $lastname `
            -SamAccountName $username ` # security account manager account name
            -DisplayName "$lastname, $firstname" ` # Nécessaire ?
            -Enabled $True ` # specifies if the account is enabled (an enabled account needs a password)
            -Path "OU=utilisateurs,DC=L1-1,DC=lab" ` # specifies the path of the OU where the object is created 
            -AccountPassword (convertto-securestring $password -AsPlainText -Force) `
            -ChangePasswordAtLogon $false ` # specifies if the password must be changed during the logon
            -PasswordNeverExpires $True # specifies if the password can expires

        Write-output("User $username has been succesfully added.")
        
    }
}

