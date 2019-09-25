<#
.SYNOPSIS
    This code will retrieve the date and time when the computer was booted.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object LastBootUpTime