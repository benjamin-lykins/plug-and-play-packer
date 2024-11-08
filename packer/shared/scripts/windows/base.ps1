# This is a demo PowerShell script

# Set time zone
Write-Host "Setting time zone to UTC..."
Set-TimeZone -Id "UTC"

# Disable Windows Firewall
Write-Host "Disabling Windows Firewall..."
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False

# Enable Remote Desktop
Write-Host "Enabling Remote Desktop..."
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0

# Create a new user
Write-Host "Creating a new user 'demoUser'..."
New-LocalUser -Name "demoUser" -Description "Demo User" -Password (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force)
Add-LocalGroupMember -Group "Administrators" -Member "demoUser"

# Clean up
Write-Host "Cleaning up..."
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force
Remove-Item -Path "C:\Users\*\AppData\Local\Temp\*" -Recurse -Force

Write-Host "Demo script completed."