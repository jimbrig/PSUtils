Function Get-FolderProperties {
    <#
    .SYNOPSIS
        Gets the properties of a folder.
    .DESCRIPTION
        Gets the properties of a folder.
    .PARAMETER Path
        Specifies the path to the folder.
    .PARAMETER LiteralPath
        Specifies the path to the folder. Unlike Path, the value of LiteralPath is used exactly as it is typed. No characters are interpreted as wildcards. If the path includes escape characters, enclose it in single quotation marks. Single quotation marks tell PowerShell not to interpret any characters as escape sequences.
    .PARAMETER Unit
        Specifies the unit of measurement to use when displaying the size of the folder.
    .EXAMPLE
        Get-FolderProperties -Path "C:\Windows"
    .EXAMPLE
        Get-FolderProperties -LiteralPath "C:\Windows"
    .EXAMPLE
        Get-FolderProperties -Path "C:\Windows" -Unit KB
    #>
    [CmdletBinding()]
    [OutputType([object])]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            ParameterSetName = "Path"
        )]
        [ValidateScript({
                if (Test-Path -Path $_ -PathType Container) {
                    return $true
                }
                throw "The argument specified must resolve to a valid folder path."
            })]
        [string[]]
        $Path,

        [Alias("PSPath")]
        [Parameter(
            Mandatory,
            ValueFromPipelineByPropertyName,
            ParameterSetName = "LiteralPath"
        )]
        [ValidateScript({
                if (Test-Path -LiteralPath $_ -PathType Container) {
                    return $true
                }
                throw "The argument specified must resolve to a valid folder path."
            })]
        [string[]]
        $LiteralPath,

        [Parameter()]
        [ValidateSet(
            "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB", # Decimal Metric (Base 10)
            "KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB" # Binary IEC (Base 2)
        )]
        [string]
        $Unit = "MiB"
    )

    BEGIN {
        $Prefix = @{
            [char] "K" = 1 # kilo
            [char] "M" = 2 # mega
            [char] "G" = 3 # giga
            [char] "T" = 4 # tera
            [char] "P" = 5 # peta
            [char] "E" = 6 # exa
            [char] "Z" = 7 # zetta
            [char] "Y" = 8 # yotta
        }

        $Base = $Unit.Contains("i") | ?: { 1024 } { 1000 }
        $Divisor = [System.Math]::Pow($Base, $Prefix[$Unit[0]])
    }

    PROCESS {
        $Process = ($PSCmdlet.ParameterSetName -cmatch "^LiteralPath") | ?: { Resolve-PSPath -LiteralPath $LiteralPath } { Resolve-PSPath -Path $Path }

        foreach ($Object in $Process) {
            try {
                if ($Object.Provider.Name -ne "FileSystem") {
                    New-ArgumentException "The argument specified must resolve to a valid path on the FileSystem provider." -Throw
                }

                $Folder = [System.IO.DirectoryInfo] $Object.ProviderPath

                Write-Verbose ("GET {0}" -f $Folder)
                $Dirs = $Files = $Bytes = 0
                # https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy
                $Result = robocopy $Folder.FullName.TrimEnd("\") \\null /l /e /np /xj /r:0 /w:0 /bytes /nfl /ndl

                if (($LASTEXITCODE -eq 16) -and ($Result[-2] -eq "Access is denied.")) {
                    New-UnauthorizedAccessException -Message ("Access to the path '{0}' is denied." -f $Folder) -Throw
                } elseif ($LASTEXITCODE -eq 16) {
                    New-ArgumentException -Message ("The specified path '{0}' is invalid." -f $Folder) -Throw
                }

                switch -Regex ($Result) {
                    "Dirs :\s+(\d+)" { $Dirs = [double] $Matches[1] - 1 }
                    "Files :\s+(\d+)" { $Files = [double] $Matches[1] }
                    "Bytes :\s+(\d+)" { $Bytes = [double] $Matches[1] }
                }

                Write-Output ([pscustomobject] @{
                        FullName = $Folder.FullName
                        Length   = $Bytes
                        Size     = "{0:n2} {1}" -f ($Bytes / $Divisor), $Unit
                        Contains = "{0} Files, {1} Folders" -f $Files, $Dirs
                        Created  = "{0:F}" -f $Folder.CreationTime
                    })

                ## EXCEPTIONS #################################################
            } catch {
                $PSCmdlet.WriteError($_)
            }
        }
    }

    END {}
}
