 <#
.SYNOPSIS
    Configures Windows 10 Security Auditing for MPSSVC Rule-Level Policy Changes.

.DESCRIPTION
    This script implements a security fix to enhance system auditing. It performs two main actions:
    1. **Enforces Advanced Audit Policy Subcategories:** It sets the 'SCENoApplyLegacyAuditPolicy' 
    registry key to '1', which ensures that the detailed Advanced Audit Policy Configuration settings 
    (like the one below) override the older, less granular category settings.
    2. **Enables MPSSVC Rule Change Auditing:** It uses 'auditpol.exe' to enable 'Success' auditing 
    for the "MPSSVC Rule-Level Policy Change" subcategory under Policy Change. This ensures an audit 
    trail is created in the Security Event Log whenever changes are successfully applied to Windows 
    Firewall rules (managed by MPSSVC.exe).

.NOTES
    Author          : Orlando G.
    LinkedIn        : https://www.linkedin.com/in/orlandogalvon/
    GitHub          : https://github.com/greetingsog
    Date Created    : 2025-11-07
    Last Modified   : 2025-11-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000575

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-AU-000575.ps1 
#>


Write-Host "1. Enabling the Audit Policy Subcategory Override..."

try {
    # Set the registry key value to 1 (Enabled)
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" `
        -Name "SCENoApplyLegacyAuditPolicy" -Value 1 -Type DWORD -Force

    Write-Host "   SCENoApplyLegacyAuditPolicy has been set to Enabled (1)."
}
catch {
    Write-Error "   Failed to set the Audit Policy Override. $($_.Exception.Message)"
}

Write-Host "---"

# --- 2. Configure Audit MPSSVC Rule-Level Policy Change ---
# This step enables 'Success' auditing for changes made to Windows Firewall rules.
Write-Host "2. Setting 'Audit MPSSVC Rule-Level Policy Change' to Success..."

try {
    # Use auditpol.exe to enable success auditing for the specific subcategory
    & "$($env:windir)\System32\auditpol.exe" /set /subcategory:"MPSSVC Rule-Level Policy Change" /success:enable

    Write-Host "   MPSSVC Rule-Level Policy Change set to Success."
}
catch {
    Write-Error "   Failed to set the MPSSVC Audit Policy. $($_.Exception.Message)"
}

Write-Host "---" 
