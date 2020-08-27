<#
.DESCRIPTION
    This script will disable NIC power management for all physical network adapters.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

$adapters = Get-NetAdapter -Physical | Get-NetAdapterPowerManagement

	foreach ($adapter in $adapters)	{
		$adapter.AllowComputerToTurnOffDevice = 'Disabled'
		$adapter | Set-NetAdapterPowerManagement
	}