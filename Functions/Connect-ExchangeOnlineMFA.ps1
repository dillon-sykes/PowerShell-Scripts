<#
.SYNOPSIS
    Connect to Exchange Online by using MFA
    
.DESCRIPTION
    If your account has MFA enabled you'll need to use the Exchange Online Remote PowerShell module.
    
.NOTES
    # Requirements:
        - Exchange Online Remote PowerShell module
          1. Open the Exchange admin center in Internet Explorer
		  2. Go to Hybrid > Setup and click the button to download the Exchange Online Remote PowerShell Module for multi-factor authentication.
    
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

Function Connect-ExchangeOnlineMFA {
	$getFile = @{
		Path = "$Env:LOCALAPPDATA\Apps\2.0\*\CreateExoPSSession.ps1"
		Recurse = $true
		ErrorAction = 'SilentlyContinue'
		Verbose = $false
	}

	$MFAExchangeModule = ((Get-ChildItem @getFile | Select-Object -ExpandProperty Target -First 1).Replace("CreateExoPSSession.ps1", ""))
	. "$MFAExchangeModule\CreateExoPSSession.ps1"
	Connect-EXOPSSession #-UserPrincipalName username@contoso.com
}