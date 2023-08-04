Function Get-ChocoOutdatedPackages {
    [CmdletBinding()]
    param (
        [Parameter()] [switch] $All,
        [Parameter()] [switch] $Outdated,
        [Parameter()] [switch] $UpToDate
    )

    if ($All) {
        $Packages = Get-ChocoPackages -All
    } elseif ($Outdated) {
        $Packages = Get-ChocoPackages -Outdated
    } elseif ($UpToDate) {
        $Packages = Get-ChocoPackages -UpToDate
    } else {
        $Packages = Get-ChocoPackages -Outdated
    }

    if ($Packages) {
        $Packages | Select-Object -Property Name, Version, LatestVersion, Summary, Description
    }
}

Function Get-ChocoPackages {
    [CmdLetBinding()]
    param (
        [Parameter()] [switch] $All,
        [Parameter()] [switch] $Outdated,
        [Parameter()] [switch] $UpToDate
    )

    $Packages = Get-ChildItem -Path "C:\ProgramData\chocolatey\lib" -Directory -ErrorAction SilentlyContinue

    if ($Packages) {
        $Packages = $Packages | Select-Object -Property Name, @{Name = "Version"; Expression = { $_.BaseName.Split('.')[1..($_.BaseName.Split('.').Count - 1)] -join '.' }}, @{Name = "LatestVersion"; Expression = { (Get-ChocoPackage -Name $_.Name).LatestVersion }}, @{Name = "Summary"; Expression = { (Get-ChocoPackage -Name $_.Name).Summary }}, @{Name = "Description"; Expression = { (Get-ChocoPackage -Name $_.Name).Description }}

        if ($All) {
            $Packages
        } elseif ($Outdated) {
            $Packages | Where-Object { $_.Version -ne $_.LatestVersion }
        } elseif ($UpToDate) {
            $Packages | Where-Object { $_.Version -eq $_.LatestVersion }
        } else {
            $Packages | Where-Object { $_.Version -ne $_.LatestVersion }
        }
    }
}
