<#
.SYNOPSIS
    This script will copy all groups from one user and add to another user.
    
.DESCRIPTION
    This script will copy all groups from one user to another user, while leaving the existing groups intact.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

function Copy-ADUserGroups {
	param (
		[Parameter(Mandatory)]
		[string]$CopyFrom,
		[Parameter(Mandatory)]
		[string]$CopyTo
	)

	$GetGroups = Get-ADUser $CopyFrom -prop MemberOf
	$CopyGroups = Get-ADUser $CopyTo -prop MemberOf
	$GetGroups.MemberOf | Where {$CopyGroups.MemberOf -notcontains $_} | Add-ADGroupMember -Members $CopyGroups
}