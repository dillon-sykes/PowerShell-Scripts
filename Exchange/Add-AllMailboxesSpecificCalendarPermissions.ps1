<#
.SYNOPSIS
	Add calendar permissions for all mailboxes to a specific calendar.

.DESCRIPTION
	This script gets a full list of mailboxes and will then set permissions on the specified mailbox calendar for all gathered users.

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
	Add-MailboxFolderPermission "your-mailbox@domain.com:\Calendar" -user $user -Accessrights PublishingEditor
}