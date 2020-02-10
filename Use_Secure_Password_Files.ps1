<#

.SYNOPSIS
Author: Brian Gade

.DESCRIPTION
Uses previously-generated secure password files to accomplish some task.

.PARAMETER KeyFile
The file path to the key file to read in.

.PARAMETER PasswordFile
The file path to the password file to read in.

.EXAMPLE
.\Use_Secure_Password_Files.ps1 -KeyFile .\key.key -PasswordFile .\password.txt

.NOTES
Change log:
v1.0.0, Brian Gade, 6/5/19 - Original Version

#>
# DEFINE PARAMETERS ----------------------------------------------
Param(
	[Parameter(Mandatory=$true)][string]$KeyFile,
	[Parameter(Mandatory=$true)][string]$PasswordFile
)
# END DEFINE PARAMETERS ------------------------------------------
# START TRANSCRIPTING --------------------------------------------
$TranscriptLogFile = '.\Use_Secure_Password_Files_Transcript.log'
Start-Transcript -Path $TranscriptLogFile -Append -NoClobber
# DEFINE VARIABLES -----------------------------------------------



# END DEFINE VARIABLES -------------------------------------------
# SCRIPT BODY ----------------------------------------------------

# Parse the encrypted files to find the plain-text password
$Key = Get-Content $KeyFile
$SecurePassword = Get-Content $PasswordFile | ConvertTo-SecureString -Key $Key
$MidPassword = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
$Password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($MidPassword)

# Do whatever you need to do with the password

# END SCRIPT BODY ------------------------------------------------
# STOP TRANSCRIPTING ---------------------------------------------
Stop-Transcript
# END SCRIPT -----------------------------------------------------