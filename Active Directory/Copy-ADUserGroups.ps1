<#
.SYNOPSIS
    This function will copy all groups from one user to another.
    
.DESCRIPTION
    This function will copy all groups from one user to another user, while leaving the existing groups intact.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
	
    # Requirements
        - This function needs to be run as an administrator
#>

function Copy-ADUserGroups {
	[CmdletBinding()]
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