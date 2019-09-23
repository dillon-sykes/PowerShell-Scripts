<#
.SYNOPSIS
    This script will create a new local administrator account.
	
.DESCRIPTION
    This script will create a new local administrator account with a username and password of your choosing.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
	
	# Requirements
        This script needs to be run as an administrator
	
    VERSION HISTORY
        1.0 | 21/03/2019 | Dillon Sykes (dillonsykes.com)
            Initial version
#>

function New-LocalAdmin {
    [CmdletBinding()]
    param (
        [string] $NewLocalAdmin,
        [securestring] $Password
    )
    begin {
    }
    process {
        New-LocalUser "$NewLocalAdmin" -Password $Password -FullName "$NewLocalAdmin" -Description "Local administrator account"
        Write-Verbose "$NewLocalAdmin local user created"
        Add-LocalGroupMember -Group "Administrators" -Member "$NewLocalAdmin"
        Write-Verbose "$NewLocalAdmin added to the local administrator group"
    }
    end {
    }
}
$NewLocalAdmin = Read-Host "New local admin username"
$Password = Read-Host -AsSecureString "Create a password for $NewLocalAdmin"

New-LocalAdmin -NewLocalAdmin $NewLocalAdmin -Password $Password -Verbose