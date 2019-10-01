<#
.SYNOPSIS
    This script will send an email with a specified attachment.
	
.DESCRIPTION
    This script will send an email with an attached file using SSL and authentication to send. This can be sent to multiple recipients.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

# Email attachment
$FileLocation = "C:\temp"
$File = "test.txt"

# Email credentials
$CredUser = "youremail@company.com"
$CredPassword = "yourpassword"

# Email Settings
$From = "example@company.com"
$Recipients = "johndoe@company.com, janedoe@company.com"
$SMTPServer = "smtp.company.com"
$Subject = "Software Log Files - " + (Get-Date -Format Y)

$EmailMsg = New-Object Net.Mail.MailMessage
$SMTP = New-Object Net.Mail.SmtpClient($SMTPServer)
$SMTP.EnableSsl = $true
$EmailMsg.From = "$From"
$EmailMsg.To.Add("$Recipients")
$EmailMsg.BodyEncoding = [system.Text.Encoding]::Unicode
$EmailMsg.SubjectEncoding = [system.Text.Encoding]::Unicode
$EmailMsg.Subject = "$Subject"
$EmailMsg.Body = "Please see the file attached."
$EmailMsg.Attachments.Add("$FileLocation\$File")
$SMTP.Credentials = New-Object System.Net.NetworkCredential("$CredUser", "$CredPassword");

# Send email
$SMTP.Send($EmailMsg)