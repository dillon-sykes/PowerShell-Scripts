<#
.SYNOPSIS
    This script will uninstall each instance of Slack that has been installed to the users AppData folders.
    
.DESCRIPTION
    This script will find all instances of Slack that are installed within all user AppData folders on a computer.
    The script will then force close slack and run a silent uninstall for each instance.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

if (Test-Path C:\Users\*\AppData\Local\slack\slack.exe){
    Kill -Name slack -force;
    (Get-ItemProperty C:\Users\*\AppData\Local\slack).FullName | Foreach-Object {Start-Process $_\Update.exe -ArgumentList "-uninstall -s" -PassThru -Wait}
}

Write-Output "Now removing all Slack shortcuts..."
if (Test-Path C:\Users\*\Desktop\slack.lnk){
    (Get-ItemProperty C:\Users\*\Desktop).FullName | Foreach-Object {Remove-Item $_\Slack.lnk -Force}
}