<#
.DESCRIPTION
    This script will extract all Wireless passwords from the local Windows account.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

$WiFiNetworks = netsh wlan show profile

ForEach ($WiFi in $WiFiNetworks) {
    If ($WiFi.Length -ge 27) {
            If ($WiFi.Substring(0,27) -eq "    All User Profile     : ") {
                $AccessPoint = $WiFi.Substring(27)
                $WLAN = netsh wlan show profile name=$AccessPoint key=clear
                $Auth = $WLAN | select-string -Pattern "Authentication"
                If ($Auth | select-string -Pattern "Open") {
                    $Result = $WLAN | select-string -Pattern "Key Content"
                    $Key = "<no password>"
                }
            Else {
                $Result = $WLAN | select-string -Pattern "Key Content"
                $Key = ($Result.ToString()).Substring(29)
                }
            $AccessPoint, $Key | Out-String
            }
        }
    }