 <#
.SYNOPSIS
    Disables the ability for a user to launch the camera from the Windows lock screen.

.DESCRIPTION
    This script enforces the 'Prevent Camera on lock screen' Group Policy setting. It checks for and creates 
    the necessary policy path (HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization) and sets the 
    DWORD value 'NoLockScreenCamera' to 1.

.NOTES
    Author          : Orlando G.
    LinkedIn        : https://www.linkedin.com/in/orlandogalvon/
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-07
    Last Modified   : 2025-11-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000005.ps1 
#>


# Define the registry path and value
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'
$ValueName    = 'NoLockScreenCamera'
$ValueData    = 1
$ValueType    = 'DWord'

Write-Host "--- Starting Policy Enforcement: Disable Lock Screen Camera ---" -ForegroundColor Yellow

# 1. Ensure the parent registry key path exists.
Write-Host "Checking/Creating key: $RegistryPath"
if (-not (Test-Path -Path $RegistryPath)) {
    Write-Host "Key not found. Creating new registry key: $RegistryPath" -ForegroundColor Cyan
    # Create the key. Out-Null suppresses the New-Item output object.
    New-Item -Path $RegistryPath -Force | Out-Null
} else {
    Write-Host "Key path exists." -ForegroundColor Green
}

# 2. Set the registry value (creates or updates the value).
# Setting 'NoLockScreenCamera' to 1 disables the camera from the lock screen.
Write-Host "Setting value '$ValueName' to $ValueData (Type: $ValueType)" -ForegroundColor Cyan
Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ValueData -Type $ValueType -Force

Write-Host "--- Policy Configuration Complete ---" -ForegroundColor Green
Write-Host "Camera access from the lock screen is now disabled." 
