Function ConvertTo-Base64String {
    <#
    .SYNOPSIS
        Converts an object to a Base64 string.
    .DESCRIPTION
        Converts an object to a Base64 string.
    .PARAMETER InputObject
        The object to convert.
    .PARAMETER Depth
        The depth to serialize the object to.
    .EXAMPLE
        ConvertTo-Base64String -InputObject "Hello World!"
    .INPUTS
        [object]
    .OUTPUTS
        [string]
    .NOTES

    #>
    [CmdletBinding()]
    [OutputType([string])]

    ## PARAMETERS #############################################################
    param (
        [Parameter(
            Mandatory,
            ValueFromPipeline
        )]
        [ValidateNotNullOrEmpty()]
        [object]
        $InputObject,

        [Parameter()]
        [int32]
        $Depth = 2
    )

    BEGIN {

    }

    PROCESS {
        try {
            try {
                $Bytes = [byte[]] $InputObject
            } catch {
                $Serialize = [System.Management.Automation.PSSerializer]::Serialize($InputObject, $Depth)
                $Bytes = [byte[]] $Serialize.ToCharArray()
            }

            Write-Output ([System.Convert]::ToBase64String($Bytes))

            ## EXCEPTIONS #################################################
        } catch [System.Management.Automation.MethodInvocationException] {
            $PSCmdlet.WriteError(( New-MethodInvocationException -Exception $_.Exception.InnerException ))
        } catch {
            $PSCmdlet.WriteError($_)
        }
    }

    END {}
}
