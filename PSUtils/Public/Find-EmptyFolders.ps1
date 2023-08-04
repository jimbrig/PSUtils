function Find-EmptyFolders {
    [CmdletBinding()]
    param (
        [Parameter()] [string] $Path = "."

    )

    # Get-ChildItem $Path

    $Result = @()

    $items = Get-ChildItem $Path -Directory -Recurse -ea 0

    foreach ($item in $items) {
        # if ($item.PSIsContainer) {
        $subitems = Get-ChildItem -Recurse -Path $item.FullName
        if (!($subitems)) {
            $Result += $item.FullName
            # Remove-Item $item.FullName -Recurse
        }
        Remove-Variable subitems -Force -ea 0
        # }
    }

    return $Result

}
