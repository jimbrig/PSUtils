Function Write-Info {
    <#
    .SYNOPSIS
        Write-Info writes a message to the console in cyan.
    .DESCRIPTION
        Write-Info writes a message to the console in cyan.
    .PARAMETER Message
        The message to write to the console.
    .EXAMPLE
        Write-Info -Message "This is an informational message."
    #>
    Param (
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    $MsgOut = "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") - [INFO]: $Message"
    Write-Host $MsgOut -ForegroundColor Cyan

}

Function Write-BoldGreen($str) {

    # Ensure PSWriteColor Module
    if (!(Get-Module -ListAvailable PSWriteColor)) {
        Install-Module PSWriteColor -Scope CurrentUser -AllowClobber -AllowPrerelease -Force
    }

    # Current console background color
    $BG = (Get-Host).ui.rawui.BackgroundColor
    Write-Color "`n" -B $BG -NoNewLine
    Write-Color " $str " -B Green -C $BG
    Write-Color "`n" -B $BG -NoNewLine

}

Function Write-Abort {
    <#
    .SYNOPSIS
        Write-Abort writes a message to the console in red and exits the script.
    .DESCRIPTION
        Write-Abort writes a message to the console in red and exits the script.
    .PARAMETER Message
        The message to write to the console.
    .PARAMETER ExitCode
        The exit code to use when exiting the script. Defaults to 1.
    .EXAMPLE
        Write-Abort -Message "This is an error message."
    #>
    Param (
        [Parameter(Mandatory = $true)]
        [string]$Message,
        [Parameter(Mandatory = $false)]
        [int]$ExitCode = 1
    )

    $MsgOut = "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") - [ABORT]: $Message"
    Write-Host $MsgOut -ForegroundColor Red
    Exit $ExitCode

}

Function Write-Err {
    <#
    .SYNOPSIS
        Write-Err writes a message to the console in red.
    .DESCRIPTION
        Write-Err writes a message to the console in red.
    .PARAMETER Message
        The message to write to the console.
    .EXAMPLE
        Write-Err -Message "This is an error message."
    #>
    Param (
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    $MsgOut = "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") - [ERROR]: $Message"
    Write-Host $MsgOut -ForegroundColor DarkRed

}

Function Write-Warn {
    <#
    .SYNOPSIS
        Write-Warn writes a message to the console in yellow.
    .DESCRIPTION
        Write-Warn writes a message to the console in yellow.
    .PARAMETER Message
        The message to write to the console.
    .EXAMPLE
        Write-Warn -Message "This is a warning message."
    #>
    Param (
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    $MsgOut = "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") - [WARN]: $Message"
    Write-Host $MsgOut -ForegroundColor DarkYellow

}

Function Write-Debug {
    <#
    .SYNOPSIS
        Write-Debug writes a message to the console in gray.
    .DESCRIPTION
        Write-Debug writes a message to the console in gray.
    .PARAMETER Message
        The message to write to the console.
    .EXAMPLE
        Write-Debug -Message "This is a debug message."
    #>
    Param (
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    $MsgOut = "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") - [DEBUG]: $Message"
    Write-Host $MsgOut -ForegroundColor DarkGray

}

Set-Alias info Write-Info
Set-Alias warn Write-Warn
Set-Alias debug Write-Debug
Set-Alias error Write-Err
Set-Alias err Write-Err
Set-Alias abort Write-Abort
