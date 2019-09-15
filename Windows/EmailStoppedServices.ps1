<#
    .NOTES
    --------------------------------------------------------------------------------
     Script:        EmailStoppedServices.ps1
     Created on:    12/05/2019 12:00 PM
     Author:        Dillon Sykes
    --------------------------------------------------------------------------------
    .DESCRIPTION
        This script will start all services set to "Automatic" or "Automatic (Delayed start)" that are in a "Stopped" state.
        After attempting to start these services, the script will email the services that failed to start.
#>

$Client="Client Name"

# Email parameters
	$From = "youremail@email.com"
	$To = "recipient@gmail.com"
	$SMTPServer = "smtp.emailserver.com"
	$Body = "Starting the following services on: ""$($env:computername)""`n"
	$Subject = " Service Status for $Client $($env:computername) "

# Start all "Automatic" and "Automatic (Delayed start)" services that are in a "Stopped" state
Get-Service | Select-Object -Property Name,Status,StartType | Where-Object {$_.Status -eq "Stopped" -and $_.StartType -eq "Automatic"} | Start-Service

# Give the services a chance to completely start
timeout /T 10

# Get all services that are set to "Automatic" and "Automatic (Delayed start)" that are still in a "Stopped" state
$Body += (Get-Service | Select-Object -Property Name,Status,StartType | Where-Object {$_.Status -eq "Stopped" -and $_.StartType -eq "Automatic"} | Out-String)

# Send email
Send-MailMessage -from $From -to $To -subject $Subject -body $Body -smtpserver $SMTPServer