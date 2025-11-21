# ========================================
# Azure Web App Deployment Script
# ========================================
# This script deploys the latest changes to your Azure Web App
#
# Usage: .\deploy-to-azure.ps1

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Azure Web App Deployment Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Configuration
$webAppName = "trawebappfrommicrosoft-gqh7cjb0gcd0bshp"
$azureRemoteName = "azure"

# Step 1: Pull latest changes from GitHub
Write-Host "[1/4] Pulling latest changes from GitHub..." -ForegroundColor Yellow
git checkout main
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to checkout main branch" -ForegroundColor Red
    exit 1
}

git pull origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to pull from origin" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Successfully pulled latest changes" -ForegroundColor Green
Write-Host ""

# Step 2: Check if azure remote exists
Write-Host "[2/4] Checking Azure remote configuration..." -ForegroundColor Yellow
$azureRemote = git remote | Where-Object { $_ -eq $azureRemoteName }
if (-not $azureRemote) {
    Write-Host "⚠ Azure remote not found. Please configure it first:" -ForegroundColor Yellow
    Write-Host "   git remote add azure https://$webAppName.scm.azurewebsites.net/$webAppName.git" -ForegroundColor White
    Write-Host ""
    Write-Host "Would you like me to configure it now? (Y/N)" -ForegroundColor Yellow
    $response = Read-Host
    if ($response -eq "Y" -or $response -eq "y") {
        git remote add azure "https://$webAppName.scm.azurewebsites.net/$webAppName.git"
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Error: Failed to add azure remote" -ForegroundColor Red
            exit 1
        }
        Write-Host "✓ Azure remote configured" -ForegroundColor Green
    } else {
        Write-Host "Deployment cancelled." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "✓ Azure remote found" -ForegroundColor Green
}
Write-Host ""

# Step 3: Push to Azure
Write-Host "[3/4] Deploying to Azure Web App..." -ForegroundColor Yellow
Write-Host "    This may take 3-5 minutes..." -ForegroundColor Gray
git push azure main --force
if ($LASTEXITCODE -ne 0) {
    Write-Host "Error: Failed to deploy to Azure" -ForegroundColor Red
    Write-Host "You may need to enter your deployment credentials." -ForegroundColor Yellow
    exit 1
}
Write-Host "✓ Successfully deployed to Azure" -ForegroundColor Green
Write-Host ""

# Step 4: Display next steps
Write-Host "[4/4] Deployment Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Next Steps:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Wait 30-60 seconds for the app to restart" -ForegroundColor White
Write-Host ""
Write-Host "2. Add these settings in Azure Portal:" -ForegroundColor White
Write-Host "   - Go to: portal.azure.com" -ForegroundColor Gray
Write-Host "   - Find: $webAppName" -ForegroundColor Gray
Write-Host "   - Configuration > Application settings" -ForegroundColor Gray
Write-Host ""
Write-Host "   Add these 5 settings:" -ForegroundColor White
Write-Host "   UI_TITLE = 🤖 AI Technology Risk Assessment" -ForegroundColor Green
Write-Host "   UI_CHAT_TITLE = 🤖 AI Risk Assessment" -ForegroundColor Green
Write-Host "   UI_CHAT_DESCRIPTION = 🛡️ This AI assistant helps with technology risk assessment" -ForegroundColor Green
Write-Host "   UI_SHOW_SHARE_BUTTON = True" -ForegroundColor Green
Write-Host "   UI_SHOW_CHAT_HISTORY_BUTTON = True" -ForegroundColor Green
Write-Host ""
Write-Host "   (Optional) Update system message:" -ForegroundColor White
Write-Host "   AZURE_OPENAI_SYSTEM_MESSAGE = You are an AI assistant specialized in technology risk assessment. You help users identify, analyze, and mitigate technology risks. Provide detailed, actionable recommendations based on industry best practices and regulatory frameworks." -ForegroundColor Green
Write-Host ""
Write-Host "3. Test your app:" -ForegroundColor White
Write-Host "   https://$webAppName.canadacentral-01.azurewebsites.net/" -ForegroundColor Cyan
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Deployment script completed successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
