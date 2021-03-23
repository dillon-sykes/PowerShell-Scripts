<#
.SYNOPSIS
	Add calendar permissions for all mailboxes to all calendars.

.DESCRIPTION
	This script gets a full list of mailboxes and will then iterate through each one, setting permissions on all gathered calendars.

.EXAMPLE
	AccessRights Options are the following:
		Author, Contributor, Editor, None, NonEditingAuthor, Owner, PublishingEditor, PublishingAuthor, Reviewer.

.NOTES
	Dillon Sykes
	dillonsykes.com
	github.com/dillon-sykes
#>

$user = Get-Mailbox -resultsize unlimited

foreach($user in Get-Mailbox -RecipientTypeDetails UserMailbox) {
	$cal = $user.alias+":\Calendar"
	Add-MailboxFolderPermission -Identity $cal -User Default -AccessRights Reviewer
}