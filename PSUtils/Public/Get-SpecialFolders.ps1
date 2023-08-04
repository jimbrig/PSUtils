Function Get-SpecialFolders {
    <#
    #>
    [CmdletBinding()]
    Param (
        [Parameter()]
        [ArgumentCompleter( {
                param ( $commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters )
                [Enum]::GetNames([Environment+SpecialFolder]) | Sort-Object | ForEach-Object { if ($_ -like "$wordToComplete*") { $_ } } }
        )]
        [ValidateScript( {
                $_ -in ([Enum]::GetNames([Environment+SpecialFolder]))
            } ) ]
        [string] $SpecialFolderName
    )

    $SpecialFolders = @()

    [Enum]::GetNames([Environment+SpecialFolder]) | Sort-Object | ForEach-Object {
        $ThisSpecialFolder = [PSCustomObject]@{
            Name      = $_
            PSCommand = "[Environment]::GetFolderPath(`"$_`")"
            Path      = [Environment]::GetFolderPath($_)
        }
        $SpecialFolders += $ThisSpecialFolder
    }

    If ($SpecialFolderName) {
        $SpecialFolders = $SpecialFolders | Where-Object Name -EQ $SpecialFolderName
    }

    return $SpecialFolders

}
