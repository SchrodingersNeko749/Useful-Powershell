param (
        

        [Parameter(Position = 0,Mandatory)]
        [string]$path,

        [Parameter(Position = 1,Mandatory)]
        [string]$delimiter,

        [Parameter(Position = 2, Mandatory)]
        [string]$extension
    )
Get-ChildItem $path\*.$extension |  
Foreach-Object { 
    $name_parts = $_.BaseName -split '-'
    # connect all parts besides the last one
    $last_part = $name_parts.Count -1  
    $dirname = $name_parts[0]
    ForEach ($index in 1..$last_part){
        
        if($index -lt $last_part){
            $dirname += "_" + $name_parts[$index]
        }
    }
    New-Item -Type Directory -Force -ErrorAction SilentlyContinue -Path $dirname | Out-Null
    Move-Item -Path $_.FullName -Destination $dirname
}
