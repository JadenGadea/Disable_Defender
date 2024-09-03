# PowerShell script to disable "Configure Automatic Updates" via Windows Registry
$UpdatePath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
$PolicyName = "AUOptions"

# Check if the path exists, if not, create it
if (-not (Test-Path $UpdatePath)) {
    New-Item -Path $UpdatePath -Force | Out-Null
}

# Set the policy to Disabled (1 represents that automatic updates are disabled)
Set-ItemProperty -Path $UpdatePath -Name $PolicyName -Value 1

# Output the result
if ((Get-ItemProperty -Path $UpdatePath).$PolicyName -eq 1) {
    Write-Output "Automatic updates have been successfully disabled."
} else {
    Write-Output "Failed to disable automatic updates."
}
