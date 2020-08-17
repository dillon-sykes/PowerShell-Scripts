<#
.SYNOPSIS
    Retrieve a list of calendar permissions for a specified mailbox.

.EXAMPLE
    Get list of calendar permissions for a specified mailbox:
        Get-UserCalendarPermissions -Mailbox john.doe@contoso.com

    Get list of permissions a user has on a specified mailbox:
        Get-UserCalendarPermissions -Mailbox john.doe@contoso.com -User jane.doe@contoso.com

.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

function Get-UserCalendarPermissions {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[string]$Mailbox,
		[string]$User
	)

	if ($User) {
		Write-Host -ForegroundColor Cyan "Calendar permissions for $Mailbox on $User"
		$Mailbox | ForEach-Object {Get-MailboxFolderPermission $_":\Calendar" -User $User} | ft -Property User,AccessRights -AutoSize
	}

	else
	{
		Write-Host -ForegroundColor Cyan "Calendar permissions for $Mailbox"
		$Mailbox | ForEach-Object {Get-MailboxFolderPermission $_":\Calendar"} | ft -Property User,AccessRights -AutoSize
	}

}