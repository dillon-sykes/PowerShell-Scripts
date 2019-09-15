<#
.SYNOPSIS
    Script to automate the process of creating a ticket, adding a time entry and completing the ticket.
	
.DESCRIPTION
    This script automates creating tickets in AutoTask by using an AutoTask PowerShell module and the AutoTask API.
    After creating a ticket the script will then add a time entry and complete the ticket.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
	
    # Requirements
    - PowerShell AutoTask module, download here: https://www.powershellgallery.com/packages/Autotask
    - AutoTask credentials
    - AutoTask API key
    
    VERSION HISTORY
        1.0 | 24/06/2019 | Dillon Sykes (dillonsykes.com)
            Initial version
#>

# Import the AutoTask module
Import-Module AutoTask

$username = 'username@email.com' # Your AutoTask username
$password = 'password' # Your AutoTask password
$password = ConvertTo-SecureString $password -AsPlainText -Force
$ApiKey = "your-api-key"
$credentials = New-Object System.Management.Automation.PSCredential("\$username",$password)
 
"Connecting to Autotask Web API.."
Connect-AutotaskWebAPI -Credential $Credentials -ApiTrackingIdentifier $ApiKey

"Connected. Creating ticket.."
$AccountID = 0 # Company reference number
$Contact = Get-AtwsContact -EMailAddress 'contactexample@email.com'
$Description = 'Server maintenance completed, please change me.'
$DueDateTime = (Get-Date).AddHours(72) # Optional: Set a due date on the ticket. This is set to be due in 3 days.
$AllocationCodeID = 29682800 # 29682801 = Remote Desktop/Workshop, 29682804 = Maintenence, 29682800 = Onsite Support, 29682861 = Non Billable Support, 29683328 = Travel
$IssueType = 'Break/Fix' # Service Request
$SubIssueType = 'Computer' # Options for Computer category: Antivirus, Backup, Computer, E-mail, Internet, Network, Other, Printer, Server, Software, VoIP/Phone, Website
$Priority = 'Normal' # Emergency, High, Low, Normal, Urgent"
$TicketType = 'Problem' # Service Request
$Source = 2 # Call
$QueueId = 'Support' # Optional: Set the QueueId. "Support, Internal"
$AssignedResourceID = 29682896
$CreatorResourceID = 29682896
$ResourceRole = 29683355 # If your resource has more than 1 role for a particular queue, you will need to specify the Role Id as well

$Status = 'New' # Options: New, In Progress, Scheduled, Complete
$Title = 'Server Maintenence - Example Client'
$Resolution = 'This is a test description, please change me.'
$PurchaseOrderNumber = 'POEX-22082019'

$Ticket_Result = $Ticket = New-AtwsTicket -AccountId $AccountId -ContactID $Contact.ID -Description $Description -DueDateTime $DueDateTime -AllocationCodeID $AllocationCodeID -IssueType $IssueType -SubIssueType $SubIssueType -Priority $Priority -TicketType $TicketType -Source $Source -QueueId $QueueId -AssignedResourceID $AssignedResourceID -CreatorResourceID $CreatorResourceID -AssignedResourceRoleID $ResourceRole -Status $Status -Title $Title -Resolution $Resolution -PurchaseOrderNumber $PurchaseOrderNumber
# Debugging purposes:
# Write-Output $Ticket.TicketNumber

if ($Ticket.TicketNumber -eq $null -eq $false) {
	Write-Host 'SUCCESS: ' -f Green -nonewline; "Ticket created, ticket number: " + $Ticket.TicketNumber
	$TicketID = $Ticket.id
	$DateWorked = Get-Date # Required
	$StartDateTime = Get-Date
	$EndDateTime = (Get-Date).AddMinutes(15)
	$HoursWorked = 0.2500
	$HoursToBill = 0.2500
	$OffsetHours = 0.0000
	$SummaryNotes = 'Ticket notes example, please change me.'
	$ResourceID = $Resource.id
	$RoleID = $Resource.DefaultServiceDeskRoleID
	$NonBillable = $true

	"Creating time entry.."
	$TimeEntry_Result = New-AtwsTimeEntry -TicketID $TicketID -DateWorked $DateWorked -StartDateTime $StartDateTime -EndDateTime $EndDateTime -HoursWorked $HoursWorked -HoursToBill $HoursToBill -OffsetHours $OffsetHours -SummaryNotes $SummaryNotes -ResourceID $AssignedResourceID -RoleID $ResourceRole -NonBillable $NonBillable

	if ($TimeEntry_Result.TicketNumber -eq $null -eq $true) {
		Write-Host 'SUCCESS: ' -f Green -nonewline; "Time entry created."
		"Completing ticket.."
		Set-AtwsTicket -TicketID $Ticket.TicketNumber -Status "Complete"
		"Script completed successfully."
	} else {
		$TimeEntry_Result.Errors
		"Error - Time entry has NOT been created."
	}
} else {
	$Ticket_Result.Errors
 "Error - Ticket has NOT been created."
}
