<#
.SYNOPSIS
	Add calendar permissions for a specific user mailbox to all calendars.

.DESCRIPTION
	This script gets a full list of mailboxes and will then iterate through each one, setting permissions for a specified user mailbox on all gathered calendars.

.EXAMPLE
	AccessRights Options are the following:
		Author, Contributor, Editor, None, NonEditingAuthor, Owner, PublishingEditor, PublishingAuthor, Reviewer.

.NOTES
	Dillon Sykes
	dillonsykes.com
	github.com/dillon-sykes
#>

$users = Get-Mailbox -resultsize unlimited | Select -ExpandProperty Alias

foreach($user in $users) {
	Add-MailboxFolderPermission $user":\Calendar" -user "your-mailbox@domain.com" -Accessrights Editor
}