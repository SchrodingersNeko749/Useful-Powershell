# examples:
# .\wafBypassPayloads.ps1 -csvFile ".\wafPayloads.csv" -type "xss" -count 5
# .\wafBypassPayloads.ps1 -csvFile ".\wafPayloads.csv" -type "sqli" -random $true

param (
    [Parameter(Mandatory=$true, HelpMessage="path to the waf-bypass csv file")]
    [string]$csvFile,

    [Parameter(Mandatory=$true, HelpMessage="payload type")]
    [string]$type,
    [Parameter(Mandatory=$false, HelpMessage="count")]
    [string]$count,
    [Parameter(Mandatory=$false, HelpMessage="random")]
    [bool]$random
)

# Path to the CSV file
$csvFile = '.\wafPayloads.csv' 


# Import CSV 
$P = Import-Csv $csvFile 

# Get third column

$output = $P | Where-Object {$_."type" -eq $type} | Select-Object -Property "payload"
if ($count -eq ""){
    $count = $output.Count
}

$output = $output | Select-Object -First $count 
if ($random){
    $rand = Get-Random -Minimum 0 -Maximum $count
    $output = $output | Select-Object -Index $rand
}

$output
