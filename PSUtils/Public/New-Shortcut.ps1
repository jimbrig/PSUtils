function New-Shortcut {
    param (
        [parameter(Mandatory = $true)] [string] $ShortcutLocation,
        [parameter(Mandatory = $true)] [string] $ShortcutTarget,
        [parameter()] [string] $Arguments,
        [parameter()] [string] $IconLocation,
        [parameter()] [switch] $Force
    )


    function Test-URI {
        [CmdletBinding()]
        Param(
            [Parameter(Mandatory = $true)]
            [String]
            $URI
        )

        $URI2 = $URI -as [System.Uri]
        $validation = ($null -ne $URI2.AbsoluteURI) -and ($URI2.Scheme -match '[http|https]')
        return $validation

    }


    if ($Force) {
        New-Item $ShortcutLocation -ItemType File -Force -ErrorAction Stop | Out-Null
        Write-Verbose "File created: $($ShortcutLocation)"
    }

    $ShortcutParent = Split-Path $ShortcutLocation -Parent
    Write-Verbose "ShortcutParent: $($ShortcutParent)"
    $ShortcutLeaf = Split-Path $ShortcutLocation -Leaf
    Write-Verbose "ShortcutLeaf: $($ShortcutLeaf)"


    $ShortcutParent = Resolve-Path $ShortcutParent -ErrorAction Stop
    Write-Verbose "ShortcutParent: $($ShortcutParent)"
    if (!($Force)) {
        if (Test-URI $ShortcutTarget) {

        } else {
            $ShortcutTarget = Resolve-Path $ShortcutTarget -ErrorAction Stop
        }
    }
    Write-Verbose "ShortcutTarget: $($ShortcutTarget)"

    if ($IconLocation) {
        $IconSplitString = $IconLocation -split ","
        $IconLocation = Resolve-Path $IconSplitString[0] -ErrorAction Stop
        if ($IconSplitString[1]) {
            $IconLocation = "$($IconLocation),$($IconSplitString[1])"
        }
        Write-Verbose "IconLocation: $($IconLocation)"
    }


    $ShortcutLocationDefinitive = Join-Path $ShortcutParent $ShortcutLeaf
    Write-Verbose "ShortcutLocationDefinitive: $($ShortcutLocationDefinitive)"


    $WshShell = New-Object -ComObject WScript.Shell

    $Shortcut = $WshShell.CreateShortcut($ShortcutLocationDefinitive)
    if ($Arguments) {
        $Shortcut.Arguments = $Arguments
    }
    $Shortcut.TargetPath = $ShortcutTarget
    if ($IconLocation) {
        $Shortcut.IconLocation = $IconLocation
    }
    # $Shortcut
    $Shortcut.Save()



}
