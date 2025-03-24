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

--------Miniconda
# Variables
$minicondaUrl = "https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe"  # Miniconda download URL
$outputPath = "$env:TEMP\Miniconda3-latest-Windows-x86_64.exe"
$installPath = "C:\ProgramData\Miniconda3"  # Install for all users

# Download Miniconda Installer
Write-Host "Downloading Miniconda installer..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $minicondaUrl -OutFile $outputPath

# Install Miniconda for All Users
Write-Host "Installing Miniconda for all users..." -ForegroundColor Cyan
Start-Process -FilePath $outputPath -ArgumentList "/InstallationType=AllUsers", "/AddToPath=1", "/RegisterPython=1", "/S", "/D=$installPath" -Wait -PassThru

# Verify Installation
Write-Host "`nVerifying Installation..." -ForegroundColor Yellow
& "$installPath\condabin\conda.bat" --version

# Clean Up Installer
Write-Host "`nCleaning up installer file..." -ForegroundColor Magenta
Remove-Item -Path $outputPath -Force

Write-Host "`nMiniconda installed successfully for all users!" -ForegroundColor Green


------WEbDeploy
# Variables
$webDeployUrl = "https://download.microsoft.com/download/7/5/F/75F9B197-4A87-42C8-88F8-91562A1EF2BD/WebDeploy_amd64_en-US.msi"  # WebDeploy 4.0 (64-bit) official download URL
$outputPath = "$env:TEMP\WebDeploy_amd64.msi"

# Download WebDeploy Installer
Write-Host "Downloading WebDeploy installer..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $webDeployUrl -OutFile $outputPath

# Install WebDeploy
Write-Host "Installing WebDeploy..." -ForegroundColor Cyan
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$outputPath`" /quiet /norestart" -Wait

# Verify Installation
Write-Host "`nVerifying Installation..." -ForegroundColor Yellow
Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match "Web Deploy" } | Select-Object Name, Version

# Clean Up Installer
Write-Host "`nCleaning up installer file..." -ForegroundColor Magenta
Remove-Item -Path $outputPath -Force

Write-Host "`nWebDeploy installed successfully!" -ForegroundColor Green


----------
# Variables
$vaultUrl = "https://<YOUR_VAULT_URL>:8200/v1/pki/ca/pem"  # Replace with your Vault CA certificate URL
$certPath = "$env:TEMP\vault-ca-cert.pem"
$certStorePath = "Cert:\LocalMachine\Root"   # Install in Trusted Root store for all users

# Download the Certificate
Write-Host "Downloading Vault CA certificate..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $vaultUrl -OutFile $certPath

# Import the Certificate
Write-Host "Importing certificate into the Trusted Root store..." -ForegroundColor Cyan
Import-Certificate -FilePath $certPath -CertStoreLocation $certStorePath

# Verify the Certificate Installation
Write-Host "`nVerifying the certificate installation..." -ForegroundColor Yellow
Get-ChildItem $certStorePath | Where-Object { $_.Subject -like "*HashiCorp*" }

# Clean Up
Write-Host "`nCleaning up certificate file..." -ForegroundColor Magenta
Remove-Item -Path $certPath -Force

Write-Host "`nVault certificate installed successfully!" -ForegroundColor Green


--Verify
Get-ChildItem "Cert:\LocalMachine\Root" | Where-Object { $_.Subject -like "*Vault*" }

