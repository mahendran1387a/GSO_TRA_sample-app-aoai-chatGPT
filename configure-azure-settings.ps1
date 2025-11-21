# ========================================
# Azure Web App Settings Configuration
# ========================================
# This script automatically adds all UI branding settings to your Azure Web App
#
# Usage: .\configure-azure-settings.ps1

param(
    [Parameter(Mandatory=$false)]
    [string]$ResourceGroup = "",

    [Parameter(Mandatory=$false)]
    [string]$WebAppName = "trawebappfrommicrosoft-gqh7cjb0gcd0bshp"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Azure Settings Configuration" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Azure CLI is installed
Write-Host "[1/3] Checking Azure CLI..." -ForegroundColor Yellow
$azCommand = Get-Command az -ErrorAction SilentlyContinue
if (-not $azCommand) {
    Write-Host "⚠ Azure CLI not found." -ForegroundColor Red
    Write-Host "Please install it from: https://learn.microsoft.com/en-us/cli/azure/install-azure-cli" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Or configure settings manually in Azure Portal:" -ForegroundColor Yellow
    Write-Host "1. Go to: portal.azure.com" -ForegroundColor White
    Write-Host "2. Find your app: $WebAppName" -ForegroundColor White
    Write-Host "3. Configuration > Application settings > + New application setting" -ForegroundColor White
    exit 1
}
Write-Host "✓ Azure CLI found" -ForegroundColor Green
Write-Host ""

# Get resource group if not provided
if ([string]::IsNullOrEmpty($ResourceGroup)) {
    Write-Host "[2/3] Finding resource group..." -ForegroundColor Yellow
    $rg = az webapp show --name $WebAppName --query resourceGroup -o tsv 2>$null
    if ($LASTEXITCODE -eq 0 -and -not [string]::IsNullOrEmpty($rg)) {
        $ResourceGroup = $rg
        Write-Host "✓ Found resource group: $ResourceGroup" -ForegroundColor Green
    } else {
        Write-Host "Please enter your resource group name:" -ForegroundColor Yellow
        $ResourceGroup = Read-Host
        if ([string]::IsNullOrEmpty($ResourceGroup)) {
            Write-Host "Error: Resource group is required" -ForegroundColor Red
            exit 1
        }
    }
} else {
    Write-Host "[2/3] Using resource group: $ResourceGroup" -ForegroundColor Yellow
}
Write-Host ""

# Configure settings
Write-Host "[3/3] Configuring application settings..." -ForegroundColor Yellow

$settings = @{
    "UI_TITLE" = "🤖 AI Technology Risk Assessment"
    "UI_CHAT_TITLE" = "🤖 AI Risk Assessment"
    "UI_CHAT_DESCRIPTION" = "🛡️ This AI assistant helps with technology risk assessment"
    "UI_SHOW_SHARE_BUTTON" = "True"
    "UI_SHOW_CHAT_HISTORY_BUTTON" = "True"
    "AZURE_OPENAI_SYSTEM_MESSAGE" = "You are an AI assistant specialized in technology risk assessment. You help users identify, analyze, and mitigate technology risks. Provide detailed, actionable recommendations based on industry best practices and regulatory frameworks."
}

Write-Host "Adding the following settings:" -ForegroundColor White
foreach ($key in $settings.Keys) {
    Write-Host "  - $key" -ForegroundColor Gray
}
Write-Host ""

# Build settings string for az CLI
$settingsArray = @()
foreach ($key in $settings.Keys) {
    $settingsArray += "$key=`"$($settings[$key])`""
}
$settingsString = $settingsArray -join " "

# Apply settings
try {
    $command = "az webapp config appsettings set -g $ResourceGroup -n $WebAppName --settings $settingsString"
    Invoke-Expression $command | Out-Null

    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Settings configured successfully!" -ForegroundColor Green
    } else {
        Write-Host "⚠ Some settings may not have been applied. Please check Azure Portal." -ForegroundColor Yellow
    }
} catch {
    Write-Host "Error configuring settings: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please configure these settings manually in Azure Portal:" -ForegroundColor Yellow
    foreach ($key in $settings.Keys) {
        Write-Host "  $key = $($settings[$key])" -ForegroundColor White
    }
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Configuration Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Your app will restart automatically." -ForegroundColor White
Write-Host "Wait 30-60 seconds, then visit:" -ForegroundColor White
Write-Host "https://$WebAppName.canadacentral-01.azurewebsites.net/" -ForegroundColor Cyan
Write-Host ""
