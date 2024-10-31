<#
.SYNOPSIS
    Install Oh My Posh for PowerShell 7.

.DESCRIPTION
    This script installs Oh My Posh using winget without any additional custom configurations.

.NOTES
    Author: Your Name
    Version: 1.2
#>

# Set strict mode and error action preference
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Install Oh My Posh using winget
function Install-OhMyPosh {
    $OhMyPoshWingetId = 'JanDeDobbeleer.OhMyPosh'
    Write-Host "Installing Oh My Posh..." -ForegroundColor Cyan
    
    if (-not (Get-Command 'oh-my-posh' -ErrorAction SilentlyContinue)) {
        try {
            winget install --id $OhMyPoshWingetId --exact --accept-source-agreements --accept-package-agreements --scope user
            Write-Host "Oh My Posh installed successfully." -ForegroundColor Green
        } catch {
            Write-Error "Failed to install Oh My Posh. Error: $_"
        }
    } else {
        Write-Host "Oh My Posh is already installed." -ForegroundColor Yellow
    }
}

# Main Script Execution
Install-OhMyPosh

Write-Host "Oh My Posh setup completed." -ForegroundColor Cyan
