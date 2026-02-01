 <#
.SYNOPSIS
    Disables the 'Always install with elevated privileges' policy, a critical security hardening step.

.DESCRIPTION
    This script enforces the recommended security configuration for the Windows Installer (MSI) service. 
    It creates the policy key path (HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer) if needed, 
    and sets the DWORD value 'AlwaysInstallElevated' to 0.

.NOTES
    Author          : Orlando G.
    LinkedIn        : https://www.linkedin.com/in/orlandogalvon/
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-07
    Last Modified   : 2025-11-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000315

.TESTED ON
    Date(s) Tested  : 2025-11-07
    Tested By       : OG
    Systems Tested  : Windows 10 Pro
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000315.ps1 
#>


# Define the registry path and value
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer'
$ValueName    = 'AlwaysInstallElevated'
$ValueData    = 0
$ValueType    = 'DWord'

Write-Host "--- Starting Policy Enforcement: Disable Always Install Elevated ---" -ForegroundColor Yellow

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
# Setting 'AlwaysInstallElevated' to 0 disables the security vulnerability.
Write-Host "Setting value '$ValueName' to $ValueData (Type: $ValueType)" -ForegroundColor Cyan
Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ValueData -Type $ValueType -Force

Write-Host "--- Policy Configuration Complete ---" -ForegroundColor Green
Write-Host "Elevated installation for non-admins is now disabled." 
