<#
.SYNOPSIS
    This script will retrieve all groups a specified user is a member of.
    
.DESCRIPTION
    This script retrieves all groups a specified user is a member of. This is specified by username.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

$User = read-host -Prompt "Enter username"
$UserDN = (Get-ADUser $user).Name

"User " + $UserDN + " is a member of the following groups:"
foreach ($Group in Get-ADGroup -Filter *){
    if ((Get-ADGroupMember $Group.Name | Select-Object -expand Name) -contains $UserDN){
	    $Group.Name
	}
}