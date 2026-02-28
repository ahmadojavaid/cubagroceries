# Stop all dev servers
Get-Process -Name "node" -ErrorAction SilentlyContinue | Stop-Process -Force
Get-Process -Name "php" -ErrorAction SilentlyContinue | Stop-Process -Force
Write-Host "✅ All servers stopped." -ForegroundColor Green
