# PowerShell script to disable Windows Firewall, ASLR, and Windows Defender Real-time Protection

# Disable Windows Firewall for all profiles
function Disable-WindowsFirewall {
    Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled False
    Write-Output "Windows Firewall has been disabled for all profiles."
}

# Disable ASLR (Address Space Layout Randomization)
function Disable-ASLR {
    $registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
    $name = "MoveImages"
    $value = 0x0  # 0 disables ASLR

    # Check if the path exists, if not, create it
    if (-not (Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force | Out-Null
    }

    # Create the registry entry to disable ASLR
    New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWord -Force
    Write-Output "ASLR has been successfully disabled."
}

# Disable Windows Defender Real-time Protection
function Disable-WindowsDefenderRealTimeProtection {
    $DefenderPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection"
    $PolicyName = "DisableRealtimeMonitoring"
    $PolicyValue = 1  # 1 to disable monitoring

    # Ensure the Defender path exists or create it
    if (-not (Test-Path $DefenderPath)) {
        New-Item -Path $DefenderPath -Force | Out-Null
    }

    # Set the policy to disable real-time monitoring
    New-ItemProperty -Path $DefenderPath -Name $PolicyName -Value $PolicyValue -PropertyType DWord -Force
    Write-Output "Windows Defender Real-time Protection has been disabled."
}

# Execute functions
Disable-WindowsFirewall
Disable-ASLR
Disable-WindowsDefenderRealTimeProtection
