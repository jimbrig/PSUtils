using namespace System.IO
using namespace System.Management.Automation

# Classes
$Classes = [FileInfo[]] (
    Get-ChildItem -Path "${PSScriptRoot}\Classes" -Filter *.ps1 -ErrorAction SilentlyContinue
)

If ($Classes) {
    ForEach ($Class in $Classes) {
        try {
            . $Class.FullName
        } catch {
            throw [ErrorRecord]::new(
                [FileLoadException] ("The class '{0}' was not loaded because an error occurred." -f $Class.BaseName),
                "ClassUnavailable",
                [ErrorCategory]::ResourceUnavailable,
                $Class.FullName
            )
        }
    }
}

$Exceptions = [FileInfo[]] (Get-ChildItem -Path "${PSScriptRoot}\Exceptions" -Filter *.ps1 -ErrorAction SilentlyContinue)

If ($Exceptions) {
    foreach ($Exception in $Exceptions) {
        try {
            . $Exception.FullName
        } catch {
            throw [ErrorRecord]::new(
                [FileLoadException] ("The exception '{0}' was not loaded because an error occurred." -f $Exception.BaseName),
                "ExceptionUnavailable",
                [ErrorCategory]::ResourceUnavailable,
                $Exception.FullName
            )
        }
    }
}

# Dot source public/private functions
$public = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Public/*.ps1') -Recurse -ErrorAction Stop)
$private = @(Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath 'Private/*.ps1') -Recurse -ErrorAction Stop)
foreach ($import in @($public + $private + $Classes + $Exceptions)) {
    try {
        . $import.FullName
    } catch {
        throw "Unable to dot source [$($import.FullName)]"
    }
}

Export-ModuleMember -Function $public.Basename


$Classes = [FileInfo[]] (Get-ChildItem -Path "${PSScriptRoot}\Classes" -Filter *.ps1 -ErrorAction SilentlyContinue)

foreach ($Class in $Classes) {
    try {
        . $Class.FullName
    } catch {
        throw [ErrorRecord]::new(
            [FileLoadException] ("The class '{0}' was not loaded because an error occurred." -f $Class.BaseName),
            "ClassUnavailable",
            [ErrorCategory]::ResourceUnavailable,
            $Class.FullName
        )
    }
}

$Exceptions = [FileInfo[]] (Get-ChildItem -Path "${PSScriptRoot}\Exceptions" -Filter *.ps1 -ErrorAction SilentlyContinue)

foreach ($Exception in $Exceptions) {
    try {
        . $Exception.FullName
    } catch {
        throw [ErrorRecord]::new(
            [FileLoadException] ("The exception '{0}' was not loaded because an error occurred." -f $Exception.BaseName),
            "ExceptionUnavailable",
            [ErrorCategory]::ResourceUnavailable,
            $Exception.FullName
        )
    }
}

$Private = [FileInfo[]] (Get-ChildItem -Path "${PSScriptRoot}\Private" -Filter *.ps1 -ErrorAction SilentlyContinue)

foreach ($Function in $Private) {
    try {
        . $Function.FullName
    } catch {
        throw [ErrorRecord]::new(
            [FileLoadException] ("The function '{0}' was not loaded because an error occurred." -f $Function.BaseName),
            "FunctionUnavailable",
            [ErrorCategory]::ResourceUnavailable,
            $Function.FullName
        )
    }
}

$Public = [FileInfo[]] (Get-ChildItem -Path "${PSScriptRoot}\Public" -Filter *.ps1 -ErrorAction SilentlyContinue)

foreach ($Function in $Public) {
    try {
        . $Function.FullName
    } catch {
        throw [ErrorRecord]::new(
            [FileLoadException] ("The function '{0}' was not loaded because an error occurred." -f $Function.BaseName),
            "FunctionUnavailable",
            [ErrorCategory]::ResourceUnavailable,
            $Function.FullName
        )
    }
}

Export-ModuleMember -Function $Public.BaseName -Alias (Get-Alias | Where-Object Source -EQ "PSUtils")

