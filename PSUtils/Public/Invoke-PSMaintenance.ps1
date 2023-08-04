function Invoke-PSMaintenance {
    [CmdletBinding()]
    param (
        [Parameter()] [switch] $UpdateAll,
        [Parameter()] [switch] $UpdatePSModules,
        [Parameter()] [switch] $UpdateHelp
    )

    # Update Chocolatey, Winget, and Scoop Packages
    $ChocoPackagesToUpdate = Get-ChocoOutdatedPackages

    # Clear Recycle Bin

    # Cleanup Desktop Icons

    # Cleanup Downloads

    # Cleanup Temp

    # Backup Settings

    # Run Windows Defender Scan
    If (Get-Command Get-MpComputerStatus -ea 0) {
        $MpScanParams = @{
            AsJob = $true
        }

        If ((Get-MpComputerStatus).FullScanOverdue -eq $true) {
            $MpScanParams.Add('ScanType', 'FullScan')
        }

        If ((Get-MpComputerStatus).QuickScanOverdue -eq $true -or (Get-MpComputerStatus).FullScanOverdue -eq $true) {
            Start-MpScan @MpScanParams
        }
    }

    # Update Modules
    If ($UpdateAll -or $UpdatePSModules) {
        Start-Job -ScriptBlock {
            Update-InstalledModule
            Uninstall-OldInstalledModules
        }
    }


    # Update Help

    # Update Windows

    # Update Drivers

    # Update Apps

    # Remove Old Modules


    cr
    rdi

    Write-Host "`n----`n"
    Remove-DownloadFolderItems

    # Backup-MySettings -All
    # Set-ChocoPinList

    if (Get-Command Get-MpComputerStatus -ea 0) {
        $MpScan_Params = @{
            AsJob = $true
        }
        if ((Get-MpComputerStatus).FullScanOverdue -eq $true) {
            $MpScan_Params.Add('ScanType', 'FullScan')
        }

        if ((Get-MpComputerStatus).QuickScanOverdue -eq $true -or (Get-MpComputerStatus).FullScanOverdue -eq $true) {
            Start-MpScan @MpScan_Params
        }
    }

    if ($UpdateAll -or $UpdatePSModules) {
        Start-Job -ScriptBlock {
            Update-InstalledModule
            Uninstall-OldInstalledModules
        }
    }
    if ($UpdateAll -or $UpdateHelp) {
        Start-Job -ScriptBlock { Update-Help -Scope AllUsers -Force -ea 0 }
    }



}
