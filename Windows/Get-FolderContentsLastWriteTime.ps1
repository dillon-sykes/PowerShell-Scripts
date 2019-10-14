<#
.SYNOPSIS
    This script produces a report on a directory of files and their last write time.
    
.DESCRIPTION
    This script creates an Excel CSV file listing a directory of files and their last write time.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

# This is the directory to run a report on
$Directory = "C:\test"

# Specify a location to save the report
$Date = (Get-Date -format "hh-mm dd-MM-yyyy")
$ReportLocation = "C:\test\DirectoryReport_$Date.csv"

Get-ChildItem $Directory\*.* | Select-Object FullName, LastWriteTime | Export-Csv $ReportLocation -NoTypeInformation