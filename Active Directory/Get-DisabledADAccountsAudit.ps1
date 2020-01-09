<#
.SYNOPSIS
    This script will retrieve any occurrances of a user account being disabled between a specific period of time.
	
.DESCRIPTION
    This script uses RPC to retrieve any occurrances of an event where a user account was disabled on an Active Directory server. 
    Information on who made this change and at what time is reported.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
	
    # Requirements
        - This script needs to be run as an administrator
	
    VERSION HISTORY
        1.0 | 05/04/2019 | Dillon Sykes (dillonsykes.com)
            Initial version
#>

# Variables
$Domain = dc.examplecompany.local
$StartDate = "21/09/2019"
$EndDate = "27/09/2019"

Get-WinEvent -ComputerName $Domain -FilterHashtable @{ LogName = "Security"; StartTime = $StartDate ; EndTime = $EndDate ; ID = 4725 } | fl