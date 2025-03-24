# Download the .NET 8.0 Hosting Bundle
Write-Host "Downloading .NET 8.0 Hosting Bundle..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $downloadUrl -OutFile $outputPath

# Install the .NET 8.0 Hosting Bundle
Write-Host "Installing .NET 8.0 Hosting Bundle..." -ForegroundColor Cyan
Start-Process -FilePath $outputPath -ArgumentList "/quiet", "/norestart" -Wait -PassThru

# Verify Installation
Write-Host "`nVerifying Installation..." -ForegroundColor Yellow
& "C:\Program Files\dotnet\dotnet.exe" --list-runtimes

# Cleanup
Write-Host "`nRemoving installer file..." -ForegroundColor Magenta
Remove-Item -Path $outputPath -Force

Write-Host "`n.NET 8.0 Hosting Bundle installed successfully!" -ForegroundColor Green
