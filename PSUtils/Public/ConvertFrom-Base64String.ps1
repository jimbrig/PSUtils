function ConvertFrom-Base64String {
    <#
    .SYNOPSIS
        Converts a Base64 string to a byte array.
    .DESCRIPTION
        Converts a Base64 string to a byte array.
    .PARAMETER InputObject
        The Base64 string to convert.
    .EXAMPLE
        ConvertFrom-Base64String -InputObject "SGVsbG8gV29ybGQh"
    .INPUTS
        [string[]]
    .OUTPUTS
        [byte[]]
    .NOTES

    #>
    [CmdletBinding()]
    Param (
        [Parameter(
            Mandatory,
            ValueFromPipeline
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$InputObject

    )

    BEGIN {

    }

    PROCESS {
        ForEach ($Object in $InputObject) {
            try {
                $Bytes = [System.Convert]::FromBase64String($Object)
                try {
                    $String = -join [char[]] $Bytes
                    Write-Output ([System.Management.Automation.PSSerializer]::Deserialize($String))
                } catch {
                    Write-Output $Bytes
                }
            } catch [System.Management.Automation.MethodInvocationException] {
                $PSCmdlet.WriteError(( New-MethodInvocationException -Exception $_.Exception.InnerException ))
            } catch {
                $PSCmdlet.WriteError($_)
            }
        }
    }

    END {

    }
}
