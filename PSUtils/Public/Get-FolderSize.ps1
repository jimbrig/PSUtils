function Get-FolderSize {
    [CmdletBinding()]
    param (
        [Parameter()] [string] $Path = ".",
        [Parameter()] [int] $Depth = 0
    )


    function Get-FolderSizePerItem {
        [CmdletBinding()]
        param (
            [Parameter(Mandatory)] [string] $Path
        )


        $TotalSize = 0
        $SizeBytes = 0
        $Files = Get-ChildItem $Path -Recurse -File -Force

        $Files | ForEach-Object {
            # $_.Length
            $TotalSize += $_.Length
            $SizeBytes += $_.Length
        }

        if ($TotalSize -gt 1024 * 1024 * 1024) {
            $TotalSize = $TotalSize / 1024 / 1024 / 1024
            $UnitOfMeasurement = "GB"
        } elseif ($TotalSize -gt 1024 * 1024) {
            $TotalSize = $TotalSize / 1024 / 1024
            $UnitOfMeasurement = "MB"
        } elseif ($TotalSize -gt 1024) {
            $TotalSize = $TotalSize / 1024
            $UnitOfMeasurement = "kB"
        } else {
            $UnitOfMeasurement = "B"
        }
        $TotalSize = [math]::Round($TotalSize, 2)
        $TotalSize = "$TotalSize $UnitOfMeasurement"


        $Results = [PSCustomObject]@{
            Path       = $Path
            TotalSize  = $TotalSize
            TotalItems = ($Files).Count
            SizeBytes  = $SizeBytes
        }


        return $Results

    }

    if ($Depth -ge 1) {
        $Result = @()
        Get-ChildItem -Path $Path -Depth ($Depth - 1) -Directory | ForEach-Object {
            $Result += Get-FolderSizePerItem $_.FullName
        }
    } else {
        $Result = Get-FolderSizePerItem $Path
    }


    return $Result


}
