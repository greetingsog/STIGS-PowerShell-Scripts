 <#
.SYNOPSIS
    Checks and configures the maximum size of the Security Event Log.

.DESCRIPTION
    Description:
    Ensures the 'MaxSize' registry value for the Security event log is set to
    a minimum of 1024000 bytes (0x000fa000) or greater.
    It automatically creates the necessary policy key (HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security)
    if it doesn't exist. 

.NOTES
    Author          : Orlando G.
    LinkedIn        : https://www.linkedin.com/in/orlandogalvon/
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-10
    Last Modified   : 2025-11-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000505

.TESTED ON
    Date(s) Tested  : 2025-11-10
    Tested By       : OG
    Systems Tested  : Windows 10 Pro
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-AU-000505.ps1 
#>


# Define the registry settings
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security"
$ValueName = "MaxSize"
$RequiredValue = 1024000 # 0x000fa000 in hexadecimal

# 1. Create the key if it does not exist
if (-not (Test-Path $RegPath)) {
    Write-Host "Registry path '$RegPath' does not exist. Creating it..."
    New-Item -Path $RegPath -Force | Out-Null
}

# 2. Get the current value
$CurrentValue = Get-ItemPropertyValue -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue

# 3. Check and set the value
if ($CurrentValue -eq $null) {
    # Value does not exist, set it to the minimum required
    Write-Host "Value '$ValueName' does not exist. Setting to $RequiredValue..."
    New-ItemProperty -Path $RegPath -Name $ValueName -Value $RequiredValue -PropertyType DWord -Force | Out-Null
    Write-Host "Registry value set successfully."
}
elseif ($CurrentValue -lt $RequiredValue) {
    # Current value is less than required, update it
    Write-Host "Current MaxSize ($CurrentValue) is less than required ($RequiredValue)."
    Write-Host "Updating '$ValueName' to $RequiredValue..."
    Set-ItemProperty -Path $RegPath -Name $ValueName -Value $RequiredValue -Type DWord -Force
    Write-Host "Registry value updated successfully."
}
else {
    # Current value is already sufficient
    Write-Host "Current MaxSize ($CurrentValue) is already sufficient (>= $RequiredValue). No changes made."
} 

