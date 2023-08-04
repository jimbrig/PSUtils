function Get-InstalledPrograms {
    [CmdletBinding()]
    param (
        [Parameter()] [string] $SearchString,
        [Parameter()] [switch] $ExtendedInfo,
        [Parameter()] [switch] $CopyToClipboard
    )

    # $Installed1 = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*
    # $Installed2 = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*
    # $Installed3 = Get-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*

    # $Installed = $Installed1 + $Installed2 + $Installed3

    # $Installed = $Installed | Where-Object DisplayName

    $Installed = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*) +
    (Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*) +
    (Get-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*)

    $Installed = $Installed | Where-Object { $_.DisplayName }


    if ($SearchString) {
        $Apps = $Installed | Where-Object { ($_.DisplayName -Like "*$($SearchString)*") -or ($_.Publisher -Like "*$($SearchString)*") }
    } else {
        $Apps = $Installed
    }

    $Apps = $Apps | Select-Object PSChildName, DisplayName, DisplayVersion, Publisher, InstallDate, UninstallString |
        Sort-Object DisplayName

    $return = foreach ($r in $Apps) {
        if ($r.UninstallString -like "*msiexec*") {
            $PSUninstallString = "cmd /c msiexec.exe /X$(($r.PSChildName)) /qn"
        } else {
            $PSUninstallString = "Start-Process '$($r.UninstallString)'"
        }

        $obj = [PSCustomObject]@{
            DisplayName    = $r.DisplayName
            DisplayVersion = $r.DisplayVersion
            Publisher      = $r.Publisher
        }

        if ($ExtendedInfo) {
            $obj | Add-Member -MemberType NoteProperty -Name PSChildName -Value $r.PSChildName
            $obj | Add-Member -MemberType NoteProperty -Name InstallDate -Value $r.InstallDate
            $obj | Add-Member -MemberType NoteProperty -Name UninstallString -Value $r.UninstallString
            $obj | Add-Member -MemberType NoteProperty -Name PSUninstallString -Value $PSUninstallString
        }

        $obj
    }

    if ($CopyToClipboard) {
        $return[-1].PSUninstallString | clip
    }

    return $return
}
