# PowerShell script to configure Windows Explorer settings

# Show hidden file extensions
$ExtensionsKeyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$ExtensionsValueName = "HideFileExt"
$ExtensionsValueData = 0  # Set to 0 to show file extensions

# Show hidden files and folders
$HiddenFilesKeyPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$HiddenFilesValueName = "Hidden"
$HiddenFilesValueData = 1  # Set to 1 to show hidden files and folders

# Function to update a registry value
function Update-RegistryValue {
    param($Path, $Name, $Data)
    # Ensure the path exists in the registry
    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }
    # Set the registry value
    Set-ItemProperty -Path $Path -Name $Name -Value $Data
}

# Update registry settings
Update-RegistryValue -Path $ExtensionsKeyPath -Name $ExtensionsValueName -Data $ExtensionsValueData
Update-RegistryValue -Path $HiddenFilesKeyPath -Name $HiddenFilesValueName -Data $HiddenFilesValueData

# Output the result
Write-Output "File extension visibility and hidden file settings have been updated."
