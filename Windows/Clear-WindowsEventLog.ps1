<#
.SYNOPSIS
    This script will clear all Windows event logs.
    
.DESCRIPTION
    This script will clear all Windows event logs from within the Event Viewer.
    This is useful if you want to cleanup a template image.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

Function Clear-EventLog {
    Write-Host "Clearing all Windows event logs" -ForegroundColor Green
    wevtutil el | Foreach-Object {
        Write-Host "Clearing Event-Log $_" -ForegroundColor DarkCyan
        wevtutil cl "$_"
    }
}
Clear-EventLog