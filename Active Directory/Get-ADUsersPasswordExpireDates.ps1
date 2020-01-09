<#
.SYNOPSIS
    This script will report the expiry dates and times of all user passwords in AD.
    
.DESCRIPTION
    This script will report the expiry date and time of all Active Directory users with passwords set to expire.
    Users who have passwords set to never expire will not be reported on.
    
.NOTES
    Dillon Sykes
    dillonsykes.com
    github.com/dillon-sykes
#>

# To find the date the password was last set, run the following command.
# Get-ADUser -filter * -Properties PasswordLastSet, PasswordNeverExpires |ft Name, PasswordLastSet, PasswordNeverExpires

# To display the expiration date rather than the password last set date, use this command.
Get-ADUser -filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} –Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed" |
Select-Object -Property "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}