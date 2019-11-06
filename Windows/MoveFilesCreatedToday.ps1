<#
.SYNOPSIS
    This script will move all files created today into a specified folder.
    
.DESCRIPTION
    This script will find all files created today that begin with the file name "Example" and move them into a specified folder.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

$SourcePath = "C:\Users\<Username>\Documents\Folder 1"
$Destination = "C:\Users\<Username>\Documents\Folder 2"
$Today = (Get-Date).Date

# Get all files in folder only
$Files = Get-ChildItem -Path $SourcePath | Where-Object {($_.CreationTime -gt $Today) -and ($_.Name -match "^Example.*")}
ForEach ($File in $Files) {
    Move-Item -Path $File.FullName -Destination $Destination
}