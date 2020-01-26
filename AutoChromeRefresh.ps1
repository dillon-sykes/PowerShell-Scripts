<#
.SYNOPSIS
    This script will continuously refresh Chrome.
    
.DESCRIPTION
    This script will refresh the active Chrome tab every x amount of seconds, forever.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

# Loop forever
While(1) {

Sleep -Seconds 3
$wshell = New-Object -ComObject wscript.shell

    if($wshell.AppActivate('Chrome')) { # Switch to Chrome
        Sleep 1 # Wait for Chrome
        $wshell.SendKeys('{F5}') # Send F5 (Refresh)
		
	} else { 
	
	# Chrome not open, exit the loop
	break;
	
	}
}