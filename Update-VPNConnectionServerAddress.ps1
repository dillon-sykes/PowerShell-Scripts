<#
.SYNOPSIS
    Update VPN connection server address.

.DESCRIPTION
    This script can be used in the instance where a VPN connection was not pushed out via GPO or a non-domain joined machine. This script can also be run using an RMM and will update both the "AllUserConnection" and user rasphone files. 

.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

$userName = ((gwmi win32_computersystem).username).split('\')[1]

$vpnFile = "C:\ProgramData\Microsoft\Network\Connections\Pbk\rasphone.pbk"
$vpnUserFile = "C:\Users\" + $userName + "\AppData\Roaming\Microsoft\Network\Connections\Pbk\rasphone.pbk"

(get-content $vpnFile) -replace 'vpn.old-domain.com', 'vpn.new-domain.com' | set-content $vpnFile
(get-content $vpnUserFile) -replace 'vpn.old-domain.com', 'vpn.new-domain.com' | set-content $vpnUserFile