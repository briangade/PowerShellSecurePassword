<#

.SYNOPSIS
Author: Brian Gade

.DESCRIPTION
Creates an AES key file and an encrypted password file so they can
be used in other PowerShell scripts to securely import a password.

.PARAMETER KeyFile
The file path to the key file to output.

.PARAMETER PasswordFile
The file path to the password file to output.

.PARAMETER Password
The plain-text password to encrypt.

.EXAMPLE
.\Create_Secure_Password_Files.ps1 -KeyFile .\key.key -PasswordFile .\password.txt -Password Pa$$w0rd

.NOTES
Change log:
v1.0.0, Brian Gade, 1/25/18 - Original Version

#>
# DEFINE PARAMETERS ----------------------------------------------
Param(
	[Parameter(Mandatory=$true)][string]$KeyFile,
	[Parameter(Mandatory=$true)][string]$PasswordFile,
	[Parameter(Mandatory=$true)][string]$Password
)
# END DEFINE PARAMETERS ------------------------------------------
# START TRANSCRIPTING --------------------------------------------

$TranscriptLogFile = '.\Create_Secure_Password_Files_Transcript.log'
Start-Transcript -Path $TranscriptLogFile -Append -NoClobber

# SCRIPT BODY ----------------------------------------------------

# Create a randomly-generated 256-bit AES encryption key and write it to a file
$Key = New-Object Byte[] 32
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($Key)
$Key | Out-File $KeyFile

# Encrypt the password into a SecureString object then output it to a file using the AES encryption key
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
$SecurePassword | ConvertFrom-SecureString -Key $Key | Out-File $PasswordFile

# END SCRIPT BODY ------------------------------------------------
# STOP TRANSCRIPTING ---------------------------------------------
Stop-Transcript
# END SCRIPT -----------------------------------------------------