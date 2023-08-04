Function Open-PSHistory {
    <#
    #>
    [CmdletBinding()]
    [Alias("OPH")]

    Param(
        [Parameter()]
        [string]
        $Editor = "notepad.exe"
    )

    BEGIN {
        $HistPath = (Get-PSReadlineOption).HistorySavePath
    }

    PROCESS {
        $Editor = $Editor.Trim('"')
        If (-not (Test-Path -Path $HistPath)) {
            New-Item -Path $HistPath -ItemType File -Force | Out-Null
        }
        Start-Process -FilePath $Editor -ArgumentList $HistPath
    }

    END {
        $null = $Editor
    }

}
