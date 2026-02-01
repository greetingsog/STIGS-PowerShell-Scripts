 <#
.SYNOPSIS
    Enforces a password requirement when a computer wakes up from sleep while running on battery power.

.DESCRIPTION
    This script sets a critical security policy by targeting a specific Power Setting GUID 
    (0e796bdb-100d-47d6-a2d5-f7d2daa51f51, which is "Require a password on wakeup"). 
    It creates the policy key path (HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\<GUID>) if necessary, 
    and sets the DWORD value 'DCSettingIndex' to 1.

.NOTES
    Author          : Orlando G.
    LinkedIn        : https://www.linkedin.com/in/orlandogalvon/
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-07
    Last Modified   : 2025-11-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000145

.TESTED ON
    Date(s) Tested  : 2025-11-07
    Tested By       : OG
    Systems Tested  : Windows 10 Pro
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000145.ps1 
#>

# Define the registry path and value
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51'
$ValueName    = 'DCSettingIndex'
$ValueData    = 1
$ValueType    = 'DWord'

Write-Host "--- Starting Registry Modification for Wakeup Password (DC) ---"

# 1. Ensure the complex, multi-level registry key path exists.
Write-Host "Checking/Creating key: $RegistryPath"
if (-not (Test-Path -Path $RegistryPath)) {
    Write-Host "Key not found. Creating new registry key: $RegistryPath" -ForegroundColor Yellow
    # Create the key. Out-Null suppresses the New-Item output object.
    New-Item -Path $RegistryPath -Force | Out-Null
} else {
    Write-Host "Key path exists." -ForegroundColor Green
}

# 2. Set the registry value (creates or updates the value).
# Setting 'DCSettingIndex' to 1 enables the password requirement on battery (DC power).
Write-Host "Setting value '$ValueName' to $ValueData (Type: $ValueType)" -ForegroundColor Cyan
Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ValueData -Type $ValueType -Force

Write-Host "--- Registry Modification Complete ---"
Write-Host "Password is now required on wakeup when on battery power." -ForegroundColor Green 
