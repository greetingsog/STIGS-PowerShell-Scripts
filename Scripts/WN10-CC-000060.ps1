 <#
.SYNOPSIS
    Configures the system to block connections to non-domain networks when a domain connection is available.

Description:
    Sets the 'fBlockNonDomain' registry value to 1 (True) to enforce this network access policy.
    It ensures the necessary Group Policy key is present before setting the value.

.NOTES
    Author          : Orlando G.
    LinkedIn        : https://www.linkedin.com/in/orlandogalvon/
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-11
    Last Modified   : 2025-11-11
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000060

.TESTED ON
    Date(s) Tested  : 2025-11-11
    Tested By       : OG
    Systems Tested  : Windows 10 Pro
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000060.ps1 
#>


# --- Define the registry settings ---
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy"
$ValueName = "fBlockNonDomain"
$RequiredValue = 1 # 0x00000001

# 1. Create the key if it does not exist
if (-not (Test-Path $RegPath)) {
    Write-Host "Registry path '$RegPath' does not exist. Creating it..."
    # The -Force parameter creates all necessary intermediate keys
    New-Item -Path $RegPath -Force | Out-Null
}

# 2. Set the registry value
Write-Host "Setting '$ValueName' to $RequiredValue..."
Set-ItemProperty -Path $RegPath -Name $ValueName -Value $RequiredValue -Type DWord -Force

# 3. Verification message
$CurrentValue = Get-ItemPropertyValue -Path $RegPath -Name $ValueName
if ($CurrentValue -eq $RequiredValue) {
    Write-Host "Verification: '$ValueName' is successfully set to $RequiredValue."
}
else {
    Write-Host "Error: Could not verify that '$ValueName' was set to $RequiredValue."
} 
