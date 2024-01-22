param (
    [Parameter(Mandatory=$true, HelpMessage="Enter the name of the property to extract. (example:result.data.id)")]
    [string]$propertyPath,

    [Parameter(Mandatory=$true, HelpMessage="Enter the path to the JSON file.")]
    [string]$jsonFilePath,
    [Parameter(Mandatory=$true, HelpMessage="Enter the path to the JSON file.")]
    [string]$outputFileName
)

#get json file contents
$jsonContent = Get-Content -Raw -Path $jsonFilePath
$jsonObject = $jsonContent | ConvertFrom-Json

# set output file name
if ($outputFileName -eq "") {
    $outputFileName = Split-Path -Path $jsonFilePath -Leaf
    $outputFileName = $outputFileName.Replace("json","txt")
}

# Split the property path into an array of property names
$propertyNames = $propertyPath -split '\.'
$propertyAttr = $propertyNames[-1]
# Navigate through the JSON object using the property names
$currentObject = $jsonObject
foreach ($propertyName in $propertyNames) {
    $currentObject = $currentObject | Select-Object -ExpandProperty $propertyName
}

if ($currentObject -is [System.Array]) {
    Write-Host "Extracting $($currentObject.Length) $propertyAttr from $jsonFilePath "
    foreach ($element in $currentObject) {
        # get id of each element
        Add-Content -Path $outputFileName -Value $element
        Start-Sleep -m 50
    }
}