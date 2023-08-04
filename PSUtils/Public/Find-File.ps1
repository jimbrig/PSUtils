function Find-File {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)] [string] $SearchString,
        [Parameter()] [switch] $ExactMatch,
        [Parameter()] [switch] $AndDirectories,
        [Parameter()] [string] $Path = "."
    )

    $Param = @{}
    if (!($AndDirectories)) {
        $Param.File = $true
    }
    if (!($ExactMatch)) {
        $SearchString = "*$SearchString*"
    }
    $Results = Get-ChildItem $Path $SearchString -Recurse @Param

    $Results = $Results.FullName


    return $Results

}
