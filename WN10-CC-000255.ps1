 <#
.SYNOPSIS
    Enforces the requirement for a Trusted Platform Module (TPM) or other security device 
    for Windows Hello for Business (WHfB) authentication.

.DESCRIPTION
    This script programmatically enforces the policy setting 'Require a Trusted Platform Module (TPM) 
    or other security device for Windows Hello for Business'. It creates the key path if necessary 
    (HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork) and sets the DWORD value 'RequireSecurityDevice' to 1.

.NOTES
    Author          : Orlando G.
    LinkedIn        : https://www.linkedin.com/in/orlandogalvon/
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-07
    Last Modified   : 2025-11-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000255

.TESTED ON
    Date(s) Tested  : 2025-11-07
    Tested By       : OG
    Systems Tested  : Windows 10 Pro
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000255.ps1 
#>


# Define the registry path and value
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork'
$ValueName    = 'RequireSecurityDevice'
$ValueData    = 1
$ValueType    = 'DWord'

Write-Host "--- Starting Registry Modification for WHfB Security ---"

# 1. Ensure the parent registry key path exists.
Write-Host "Checking/Creating key: $RegistryPath"
if (-not (Test-Path -Path $RegistryPath)) {
    Write-Host "Key not found. Creating new registry key: $RegistryPath" -ForegroundColor Yellow
    # Create the key. Out-Null suppresses the New-Item output object.
    New-Item -Path $RegistryPath -Force | Out-Null
} else {
    Write-Host "Key path exists." -ForegroundColor Green
}

# 2. Set the registry value (creates or updates the value).
# Setting 'RequireSecurityDevice' to 1 enforces hardware security for WHfB.
Write-Host "Setting value '$ValueName' to $ValueData (Type: $ValueType)" -ForegroundColor Cyan
Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ValueData -Type $ValueType -Force

Write-Host "--- Registry Modification Complete ---"
Write-Host "The system is now configured to require a security device for Windows Hello for Business." -ForegroundColor Green 

