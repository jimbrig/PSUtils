Function Write-Log {
    <#
    .SYNOPSIS
        Write a log to a designated location on the local file system.
    .DESCRIPTION
        This function is used to write application specific logs to a log file.
    .PARAMETER LogPath
        Directory where logs are stored: defaults to "$env:APPDATA\powershell\Logs".
    .PARAMETER LogFileName
        Filename of the log to be appended after the date: defaults to "PSWinSetup".
    .PARAMETER DeleteAfterDays
        Number of days to retain logs for.
    .PARAMETER Type
        One of DEBUG, INFO, WARNING, ERROR
    .PARAMETER Text
        Text to write to log.
    .EXAMPLE
        Write-Log -Type INFO -Text Script Started
        Write-Log -Type ERROR -Text Script Failed
    #>
    [CmdletBinding()]
    param (
        [string]$LogPath = "$env:APPDATA\PowerShell\Logs",
        [string]$LogFileName = "PSUtils",
        [int]$DeleteAfterDays = $null,
        [ValidateSet('DEBUG', 'INFO', 'WARNING', 'ERROR')]
        [string]$Type,
        [string]$Text
    )

    if (!(Test-Path -Path $LogPath)) { New-Item -Path $LogPath -ItemType Directory -Force }

    [string]$LogFile = '{0}\{1}_{2}.log' -f $LogPath, $(Get-Date -Format 'yyyy-MM-dd'), $LogfileName
    If (!(Test-Path -Path $LogFile)) { New-Item -Path $LogFile -ItemType File -Force }
    $LogEntry = '{0}: <{1}> {2}' -f $(Get-Date -Format 'yyyy-MM-dd HH:MM:ss'), $Type, $Text
    Add-Content -Path $LogFile -Value $LogEntry
    $Limit = (Get-Date).AddDays(-$DeleteAfterDays)
    Get-ChildItem -Path $LogPath -Filter "*$LogfileName.log" | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $Limit } | Remove-Item -Force
}

Function Open-Logs {
    <#
    #>
    [CmdletBinding()]
    param(
        [string]$LogPath = "$env:APPDATA\PowerShell\Logs",
        [string]$LogFileName = "PSUtils",
        [string]$Editor = "notepad.exe"
    )

    try {
        $LogFile = Get-ChildItem -Path $LogPath -Filter "*$LogFileName.log" | Sort-Object -Property LastWriteTime -Descending | Select-Object -First 1
        Start-Process -FilePath $Editor -ArgumentList $LogFile.FullName
    } catch {
        Write-Log -Type ERROR -Text "Failed to open log file: $LogFile"
    }
}
