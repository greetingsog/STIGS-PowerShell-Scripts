 <#
.SYNOPSIS
    Disables the slideshow feature on the Windows Lock Screen.

.DESCRIPTION
    Sets the 'NoLockScreenSlideshow' registry value to 1 (True) under the
    Personalization policies key. 

.NOTES
    Author          : Orlando G.
    LinkedIn        : https://www.linkedin.com/in/orlandogalvon/
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-12
    Last Modified   : 2025-11-12
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000010

.TESTED ON
    Date(s) Tested  : 2025-11-12
    Tested By       : OG
    Systems Tested  : Windows 10 Pro
    PowerShell Ver. : 5.1

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000010.ps1 
#>

# --- Define the registry settings ---
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"
$ValueName = "NoLockScreenSlideshow"
$RequiredValue = 1 # 0x00000001

# 1. Create the key if it does not exist
if (-not (Test-Path $RegPath)) {
    Write-Host "Registry path '$RegPath' does not exist. Creating it..."
    # The -Force parameter creates all necessary intermediate keys
    New-Item -Path $RegPath -Force | Out-Null
}

# 2. Set the registry value
Write-Host "Setting '$ValueName' to $RequiredValue..."
# The -Force parameter overwrites the value if it already exists
Set-ItemProperty -Path $RegPath -Name $ValueName -Value $RequiredValue -Type DWord -Force

# 3. Verification message
$CurrentValue = Get-ItemPropertyValue -Path $RegPath -Name $ValueName
if ($CurrentValue -eq $RequiredValue) {
    Write-Host "Verification: The policy '$ValueName' is successfully set to $RequiredValue (Disabled)."
}
else {
    Write-Host "Error: Could not verify that '$ValueName' was set to $RequiredValue."
} 
