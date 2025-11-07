 <#
.SYNOPSIS
Disables the enumeration (listing) of local administrator accounts in the Credentials UI.

.DESCRIPTION
This script enforces a security policy by creating or modifying the registry key 
'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI'. 
It sets the DWORD value 'EnumerateAdministrators' to 0.

.NOTES
    Author          : Orlando G.
    LinkedIn        : https://www.linkedin.com/in/orlandogalvon/
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-07
    Last Modified   : 2025-11-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000200

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000200.ps1 
#>


# Define the registry path and value
$RegistryPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI'
$ValueName    = 'EnumerateAdministrators'
$ValueData    = 0
$ValueType    = 'DWord'

Write-Host "--- Starting Registry Modification ---"

# 1. Ensure the parent registry key path exists.
# The CredUI key may not exist by default, so we create it.
Write-Host "Checking/Creating key: $RegistryPath"
if (-not (Test-Path -Path $RegistryPath)) {
    Write-Host "Key not found. Creating new registry key: $RegistryPath" -ForegroundColor Yellow
    # Create the key. The -Force parameter creates it and any necessary parent keys.
    New-Item -Path $RegistryPath -Force | Out-Null
} else {
    Write-Host "Key path exists." -ForegroundColor Green
}

# 2. Set the registry value (creates or updates the value).
# This sets "EnumerateAdministrators" to 0, which disables administrator enumeration.
Write-Host "Setting value '$ValueName' to $ValueData (Type: $ValueType)" -ForegroundColor Cyan
Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ValueData -Type $ValueType -Force

Write-Host "--- Registry Modification Complete ---"
Write-Host "Administrator enumeration in the Credentials UI is now disabled." -ForegroundColor Green 
