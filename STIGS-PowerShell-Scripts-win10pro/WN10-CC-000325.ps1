 <#
.SYNOPSIS
    Checks for and enforces the policy to disable automatic sign-in after a system restart.

.DESCRIPTION
    This script verifies the status of the 'DisableAutomaticRestartSignOn' registry value under 
    HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\. If the value is missing or 
    not set to the required compliance level of 1, the script updates it to 1 to enforce the policy.

.NOTES
    Author          : Orlando G.
    LinkedIn        : https://www.linkedin.com/in/orlandogalvon/
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-07
    Last Modified   : 2025-11-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000325

.TESTED ON
    Date(s) Tested  : 2025-11-07
    Tested By       : OG
    Systems Tested  : Windows 10 Pro
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000325.ps1 
#>


# Define the registry path and desired value
$RegistryPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$ValueName    = 'DisableAutomaticRestartSignOn'
$DesiredValue = 1
$ValueType    = 'DWord'

Write-Host "--- Checking Policy: Disable Automatic Restart Sign-On ---"

# 1. Test if the key path exists.
if (-not (Test-Path -Path $RegistryPath)) {
    Write-Host "Policy path not found. Creating key: $RegistryPath" -ForegroundColor Yellow
    New-Item -Path $RegistryPath -Force | Out-Null
}

# 2. Check the existing value.
$CurrentValue = Get-ItemProperty -Path $RegistryPath -Name $ValueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $ValueName

# 3. Determine if enforcement is needed.
if ($CurrentValue -ne $DesiredValue) {
    Write-Host "Current value for '$ValueName' is '$CurrentValue'. Policy requires $DesiredValue." -ForegroundColor Red

    # Enforce the required configuration
    Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $DesiredValue -Type $ValueType -Force
    Write-Host "ACTION TAKEN: Set '$ValueName' to $DesiredValue (Disabled)." -ForegroundColor Green
}
else {
    Write-Host "Policy check successful. '$ValueName' is already set to $DesiredValue (Compliant)." -ForegroundColor Green
}

Write-Host "--- Policy Check Complete ---" 
