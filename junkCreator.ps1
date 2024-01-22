param (
    [Parameter(Mandatory=$true)]
    [int]$SizeInKB,
    [Parameter(Mandatory=$true)]
    [string]$FilePath
)

$numbers = "0123456789"
$bufferSize = 1MB
$bytesToWrite = $SizeInKB * 1KB

$fileStream = [System.IO.File]::CreateText($filePath)

$bytesWritten = 0
while ($bytesWritten -lt $bytesToWrite) {
    $remainingBytes = $bytesToWrite - $bytesWritten
    $bytesToFill = [Math]::Min($bufferSize, $remainingBytes)

    $buffer = $numbers * ($bytesToFill / $numbers.Length)
    $fileStream.Write($buffer)

    $bytesWritten += $bytesToFill
}

$fileStream.Close()

Write-Host "Junk file created at: $filePath"