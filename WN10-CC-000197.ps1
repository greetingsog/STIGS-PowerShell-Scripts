 <#
.SYNOPSIS
    Disables Microsoft consumer features and promotional content on the system.

.DESCRIPTION
This script programmatically enforces the 'Turn off Microsoft consumer experiences' Group Policy setting. 
It ensures the required registry path exists (HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent) 
and then sets the DWORD value 'DisableWindowsConsumerFeatures' to 1. This action is crucial for 
removing personalized recommendations, suggested apps, and consumer-focused content often found 
in Windows 10 and 11 Start Menus and Notifications.

.NOTES
    Author          : Orlando G.
    LinkedIn        : linkedin.com/in/#/
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-07
    Last Modified   : 2025-11-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000197

.TESTED ON
    Date(s) Tested  : 2025-11-07
    Tested By       : OG
    Systems Tested  : Windows 10 Pro
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000197.ps1 
#>

# Define the registry path where the value will be set
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
$ValueName    = 'DisableWindowsConsumerFeatures'
$ValueData    = 1
$ValueType    = 'DWord'

# 1. Ensure the registry key path exists. The -Force parameter creates it if it doesn't.
# The CloudContent key is part of a policy path, so we want to be sure it's there.
if (-not (Test-Path -Path $RegistryPath)) {
    Write-Host "Creating new registry key: $RegistryPath"
    New-Item -Path $RegistryPath -Force | Out-Null
}

# 2. Set the registry value (creates the value if it doesn't exist, or updates it if it does).
Write-Host "Setting registry value: $ValueName to $ValueData"
Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $ValueData -Type $ValueType -Force

Write-Host "Registry modification complete." 
