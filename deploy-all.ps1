# ========================================
# Complete Deployment Script
# ========================================
# This script does EVERYTHING:
# 1. Pulls latest code from GitHub
# 2. Deploys to Azure Web App
# 3. Configures all settings
#
# Just run this ONE command: .\deploy-all.ps1

Write-Host ""
Write-Host "╔════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                                        ║" -ForegroundColor Cyan
Write-Host "║   AI Risk Assessment Deployment Tool   ║" -ForegroundColor Cyan
Write-Host "║                                        ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Step 1: Deploy code
Write-Host "STEP 1: Deploying code to Azure..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
.\deploy-to-azure.ps1
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "✗ Code deployment failed. Please fix errors above." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "STEP 2: Configuring Azure settings..." -ForegroundColor Yellow
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Gray
.\configure-azure-settings.ps1
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "✗ Settings configuration failed." -ForegroundColor Red
    Write-Host "  Your code is deployed, but you'll need to configure settings manually." -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "╔════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                                        ║" -ForegroundColor Green
Write-Host "║   ✓ DEPLOYMENT SUCCESSFUL!             ║" -ForegroundColor Green
Write-Host "║                                        ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "Your AI Risk Assessment app is now live!" -ForegroundColor White
Write-Host ""
Write-Host "App URL:" -ForegroundColor White
Write-Host "https://trawebappfrommicrosoft-gqh7cjb0gcd0bshp.canadacentral-01.azurewebsites.net/" -ForegroundColor Cyan
Write-Host ""
Write-Host "Wait 60 seconds for the app to restart, then open the URL above." -ForegroundColor Yellow
Write-Host ""
