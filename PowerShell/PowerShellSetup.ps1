
<#
.SYNOPSIS
    Main PowerShell 7 Terminal Setup Script for Windows Terminal on Windows 11.

.DESCRIPTION
    This script initiates the setup process for PowerShell 7 in Windows Terminal by calling other smaller and more manageable scripts.
    It ensures that all required modules, tools, and configurations are properly installed.

.NOTES
    Author: Your Name
    Version: 3.0
#>

# Set strict mode and error action preference
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Define script paths for individual setup scripts
$ModuleInstallationScript = "$PSScriptRoot\InstallModules.ps1"
$OhMyPoshInstallationScript = "$PSScriptRoot\InstallOhMyPosh.ps1"

# Main Script Execution
Write-Host "Starting streamlined PowerShell environment setup..." -ForegroundColor Cyan

# Install PowerShell modules
. $ModuleInstallationScript

# Install Oh My Posh and generate configuration
. $OhMyPoshInstallationScript

Write-Host "Setup script completed successfully. Please restart your terminal to apply changes." -ForegroundColor Cyan