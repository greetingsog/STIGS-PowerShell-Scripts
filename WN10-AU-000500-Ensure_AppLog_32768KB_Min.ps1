 <#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Orlando G.
    LinkedIn        : --
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-06
    Last Modified   : 2025-11-06
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000500.ps1 
#>

# Define the registry path and values
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$ValueName    = "MaxSize"
# The hexadecimal value 00008000 (32,768 in decimal)
# PowerShell automatically handles the dword type when using this cmdlet
$ValueData    = 32768 

# Check if the key exists, and create it if it doesn't
# The 'Policies' path is likely to exist, but it's good practice to ensure the path is present.
if (-not (Test-Path $RegistryPath)) {
    Write-Host "Registry path '$RegistryPath' does not exist. Creating it now..."
    # The -Force parameter creates any intermediate keys needed
    New-Item -Path $RegistryPath -Force | Out-Null
    Write-Host "Path created."
}

# Set the MaxSize value. The -Type DWord is implied when passing an integer,
# but explicitly setting it ensures clarity and correctness.
Write-Host "Setting registry value '$ValueName' to $ValueData (0x8000)..."
Set-ItemProperty `
    -Path $RegistryPath `
    -Name $ValueName `
    -Value $ValueData `
    -Type DWord `
    -Force

Write-Host "Registry change complete."

# Optional: Verify the change
Write-Host "Verifying change..."
Get-ItemProperty -Path $RegistryPath -Name $ValueName | Select-Object -ExpandProperty $ValueNamej 
