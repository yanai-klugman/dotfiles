<#
.SYNOPSIS
    Install essential PowerShell modules for PowerShell 7.

.DESCRIPTION
    This script installs essential PowerShell modules to enhance the terminal experience.

.NOTES
    Author: Your Name
    Version: 1.0
#>

# Set strict mode and error action preference
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Tools and modules to install
$ModulesToInstall = @('PSReadLine', 'z', 'Terminal-Icons', 'PSFzf', 'PSWriteColor')
$TotalSteps = $ModulesToInstall.Count
$CurrentStep = 0

# Update progress with modern syntax
function Update-Progress {
    param (
        [string]$Activity,
        [string]$Status
    )
    
    $script:CurrentStep++
    Write-Progress -Activity $Activity -Status $Status -PercentComplete (($script:CurrentStep / $TotalSteps) * 100)
}

# Install a PowerShell module
function Install-PowerShellModule {
    param (
        [string]$ModuleName
    )
    
    Update-Progress -Activity 'Installing PowerShell Module' -Status "Installing $ModuleName..."

    try {
        if (-not (Get-PSRepository -Name 'PSGallery' -ErrorAction SilentlyContinue)) {
            Register-PSRepository -Default -ErrorAction Stop
        }

        Install-Module -Name $ModuleName -Scope CurrentUser -Force -AllowClobber -ErrorAction Stop
        Write-Host "$ModuleName module installed successfully." -ForegroundColor Green
    } catch {
        Write-Error "Failed to install $ModuleName module. Error: $_"
    }
}

# Install PowerShell modules
$ModulesToInstall | ForEach-Object { Install-PowerShellModule -ModuleName $_ }

Write-Host "Module installation completed." -ForegroundColor Cyan
