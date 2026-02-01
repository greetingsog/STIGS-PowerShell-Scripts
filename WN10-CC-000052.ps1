 <#
.SYNOPSIS
    Restricts the Elliptic Curve Cryptography (ECC) curves available for the system to use in TLS/SSL negotiations.

.DESCRIPTION
    This script is a strong security hardening measure that implements the 'SSL/TLS Policy Settings' 
    Group Policy configuration. It creates the policy key path if necessary and sets the REG_MULTI_SZ 
    value 'EccCurves' to list only two modern, strong NIST curves: NistP384 and NistP256.

.NOTES
    Author          : Orlando G.
    LinkedIn        : https://www.linkedin.com/in/orlandogalvon/
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-07
    Last Modified   : 2025-11-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000052

.TESTED ON
    Date(s) Tested  : 2025-11-07
    Tested By       : OG
    Systems Tested  : Windows 10 Pro
    PowerShell Ver. : 5.1 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000052.ps1 
#>


# Define the registry path and value details
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002'
$ValueName    = 'EccCurves'

# Define the multi-string array of curve names
# REG_MULTI_SZ is represented in PowerShell by a simple string array.
$ValueData    = @("NistP384", "NistP256")
$ValueType    = 'MultiString'

Write-Host "--- Starting Registry Modification for ECC Curve Restriction ---"

# 1. Ensure the multi-level registry key path exists.
Write-Host "Checking/Creating key: $RegistryPath"
if (-not (Test-Path -Path $RegistryPath)) {
    Write-Host "Key not found. Creating new registry key: $RegistryPath" -ForegroundColor Yellow
    # Create the key. Out-Null suppresses the New-Item output object.
    New-Item -Path $RegistryPath -Force | Out-Null
} else {
    Write-Host "Key path exists." -ForegroundColor Green
}

# 2. Set the registry value (creates or updates the value).
# The MultiString type automatically handles the null terminators required for REG_MULTI_SZ.
Write-Host "Setting value '$ValueName' to $($ValueData -join ', ') (Type: $ValueType)" -ForegroundColor Cyan
Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ValueData -Type $ValueType -Force

Write-Host "--- Registry Modification Complete ---"
Write-Host "System is now restricted to using NistP384 and NistP256 ECC curves for TLS/SSL." -ForegroundColor Green 
