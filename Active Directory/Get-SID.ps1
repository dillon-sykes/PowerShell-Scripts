<#
.DESCRIPTION
    This function will retrieve a specific users SID (Security Identifier).
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

function Get-SID {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$true)]
		[System.Object]$user
	)

	Try {
		$domain = $env:USERDOMAIN
		$objUser = New-Object System.Security.Principal.NTAccount("$domain","$user") -ErrorAction Stop
		$strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
		$strSID.Value
		Write-Host
	}
	
	Catch {
		Write-Error -Message 'Failed to get user SID.'
	}
}