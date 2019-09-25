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

# User to copy groups from
$CopyFromUser = 'test1'

# User to copy groups to
$CopyToUser = 'test'

$GetGroups = Get-ADUser $CopyFromUser -prop MemberOf
$CopyGroups = Get-ADUser $CopyToUser -prop MemberOf
$GetGroups.MemberOf | Where {$CopyGroups.MemberOf -notcontains $_} | Add-ADGroupMember -Members $CopyGroups