Write-Output '=== Installing Mondoo ==='
Create-Item -type directory -path 'C:\packer'
Set-Location -Path 'C:\packer'
Invoke-WebRequest -Uri https://releases.mondoo.com/mondoo/10.12.2/mondoo_10.12.2_windows_amd64.msi -OutFile mondoo.msi
Start-Process -Wait msiexec -ArgumentList "/qn /i mondoo.msi REGISTRATIONTOKEN=$env:MONDOO_REGISTRATION_TOKEN"