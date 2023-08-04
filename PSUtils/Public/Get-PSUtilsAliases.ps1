function Get-PSUtilsAliases {
    [CmdletBinding()]
    param (

    )

    Get-Alias | Where-Object Source -EQ "PSUtils" | Select-Object Name, ResolvedCommand | Format-Table

}
