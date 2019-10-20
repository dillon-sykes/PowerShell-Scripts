<#
.SYNOPSIS
    Powershell script to automate logging into Exchange 2016 OWA with Internet Explorer.
    
.DESCRIPTION
    This script will launch Internet Explorer, send credentials and login to Exchange 2016 OWA.
    
.NOTES
    This was created for learning purposes, this script has no real world use.

    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

$username = "domain\username"; # Your Exchange username
$password = "yourpassword"; # Your password
$loginUrl = "https://mail.contoso.com/owa/";

Write-Host -ForegroundColor Green "Launching browser..";

# Initialize browser
$ie = New-Object -com internetexplorer.application;
$ie.visible = $true;
$ie.navigate($loginUrl);
while ($ie.Busy -eq $true) { Start-Sleep -Seconds 1; } # Wait for browser idle

Write-Host -ForegroundColor Green "Sending credentials..";

# Login
($ie.document.getElementsByName("username") |select -first 1).value = $username;
($ie.document.getElementsByName("password") |select -first 1).value = $password;
($ie.document.getElementsByClassName("signinbutton") |select -first 1).click();
while ($ie.Busy -eq $true) { Start-Sleep -Seconds 1; } # Wait for browser idle

Write-Host -ForegroundColor Green "Complete!";