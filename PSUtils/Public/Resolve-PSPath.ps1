function Resolve-PSPath {
    [CmdletBinding()]
    [OutputType([object])]

    ## PARAMETERS #############################################################
    param (
        [Parameter(
            Position = 0,
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            ParameterSetName = "Path"
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Path,

        [Alias("PSPath")]
        [Parameter(
            Mandatory,
            ValueFromPipelineByPropertyName,
            ParameterSetName = "LiteralPath"
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $LiteralPath
    )

    ## PROCESS ################################################################
    process {
        foreach ($PSPath in $PSBoundParameters[$PSCmdlet.ParameterSetName]) {
            try {
                if ($PSCmdlet.ParameterSetName -eq "Path") {
                    try {
                        $PSPath = $PSCmdlet.SessionState.Path.GetResolvedPSPathFromPSPath($PSPath)
                    } catch [System.Management.Automation.ItemNotFoundException] {
                        $PSPath = $_.Exception.InnerException.ItemName
                    }
                }

                foreach ($String in $PSPath) {
                    $Provider = $Drive = $null
                    $ProviderPath = $PSCmdlet.SessionState.Path.GetUnresolvedProviderPathFromPSPath($String, [ref] $Provider, [ref] $Drive)

                    Write-Output ([pscustomobject] @{
                            ProviderPath = $ProviderPath
                            Provider     = $Provider
                            Drive        = $Drive
                        })
                }

                ## EXCEPTIONS #################################################
            } catch [System.Management.Automation.MethodInvocationException] {
                $PSCmdlet.WriteError(( New-MethodInvocationException -Exception $_.Exception.InnerException ))
            } catch {
                $PSCmdlet.WriteError($_)
            }
        }
    }
}
