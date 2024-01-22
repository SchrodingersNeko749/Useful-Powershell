param(
    [Parameter(Mandatory = $true)]
    [string]$Path,

    [Parameter(Mandatory = $true)]
    [string]$Pattern
)

Get-ChildItem -Path $Path -Recurse | Select-String -Pattern $Pattern