<#
.SYNOPSIS
    Create a report of all Active Directory users information & membership.
    
.DESCRIPTION
    This script will export a CSV containing the username, department, job title and group membership of each Active Directory user.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

Import-Module ActiveDirectory

# Create an array to store all properties you want to include with your ADUser object
$properties = @(
    "Department",
    "Company",
    "Title"
)

# Grab all of the user objects that are enabled and store them in a variable
$users = Get-ADUser -Filter {Enabled -eq $true} -Properties $properties

# Create an empty array to store the custom objects you'll create
$array = @()
foreach ($user in $users) 
{
    # Grab all of the group objects the user is a part of and store them in a variable
    $membership = Get-ADPrincipalGroupMembership -Identity $user.SamAccountName

    # Map each additional property you want in your custom object from the $properties array created earlier. Use the [ordered] class to ensure that the hash table maintains the same column order as you see in the script.
    $hash = [ordered]@{
        User = $user.Name
        Username = $user.SamAccountName
        Department = $user.Department
        Company = $user.Company
        Title = $user.Title
        Groups = (@($membership.Name) -join ', ')
    }

    $object = New-Object -Type PSObject -Property $hash
    $array += $object
}

$array | Sort User | Export-CSV -Path "C:\users\$env:USERNAME\desktop\export.csv" -NoTypeInformation