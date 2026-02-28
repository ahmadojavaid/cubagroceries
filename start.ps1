# Start all servers

Write-Host '📱 Starting Flutter...' -ForegroundColor Yellow
Start-Process powershell -ArgumentList '-NoExit', '-Command', 'cd "H:\cubagroceries\mobile"; flutter run'

Start-Sleep -Seconds 3
Start-Process 'https://cubagroceries.test'

Write-Host '✅ All servers started!' -ForegroundColor Green
