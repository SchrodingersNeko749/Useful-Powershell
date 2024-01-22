Get-NetTCPConnection -State Listen | ForEach-Object {
    $processId = $_.OwningProcess
    $process = Get-Process -Id $processId -ErrorAction SilentlyContinue

    $owner = $null
    if ($process) {
        $owner = (Get-WmiObject -Class Win32_Process -Filter "ProcessId = $processId").GetOwner().User
    }

    [PSCustomObject]@{
        LocalAddress = $_.LocalAddress
        LocalPort = $_.LocalPort
        ProcessName = $process.Name
        ProcessId = $process.Id
        ProcessOwner = $owner
        ConnectionState = $_.State
    }
} | Format-Table -AutoSize