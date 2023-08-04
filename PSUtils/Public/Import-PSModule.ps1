# function Import-PSModule {

#     [CmdletBinding()]

#     param (
#         [Parameter()]
#         [ArgumentCompleter( {
#                 param ( $commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters )
#                 Get-ChildItem "$(Join-Path $($env:USERPROFILE) -ChildPath "Dev\")$wordToComplete*" -Directory -Name | ForEach-Object { $_ } }
#         )]
#         [ValidateScript( {
#                 $_ -in (Get-ChildItem "$(Join-Path $($env:USERPROFILE) -ChildPath "Git\")" -Directory -Name)
#             } ) ]
#         [string] $Module,
#         [Parameter()] [switch] $All,
#         [Parameter()] [switch] $ShowVersion
#     )


#     function Import-MyModuleInternal {

#         [CmdletBinding()]
#         param (
#             [Parameter(Mandatory)] [string] $InternalModule
#         )

#         $ShowVersion = $true

#         $ModuleManifest = "$(Join-Path $($env:USERPROFILE) -ChildPath "Git")\$($InternalModule)\$InternalModule.psd1"

#         if (Test-Path $ModuleManifest) {
#             if ($ShowVersion) {
#                 $ModuleVersion = Get-Module $InternalModule | Where-Object Path -Like "*\git\*" | Select-Object Name, Version
#                 Write-Verbose "Old version: $($ModuleVersion.Name) $($ModuleVersion.Version)" -Verbose
#             }

#             Import-Module $ModuleManifest -Force -Global

#             if ($ShowVersion) {
#                 $ModuleVersion = Get-Module $InternalModule | Where-Object Path -Like "*\git\*" | Select-Object Name, Version
#                 Write-Verbose "New version: $($ModuleVersion.Name) $($ModuleVersion.Version)" -Verbose
#             }
#         } else {
#             Write-Warning "Module $ModuleManifest not found"
#         }

#     }





#     if ($All) {

#         $Folders = Get-ChildItem (Join-Path $env:USERPROFILE "Git") | Where-Object Name -NE "JaapsTools"
#         # Write-Verbose ($Folders | Out-String) -Verbose
#         foreach ($folder in $Folders) {
#             Write-Verbose $folder.Name
#             Import-MyModuleInternal -InternalModule $folder.Name
#         }
#         Import-MyModuleInternal -InternalModule JaapsTools

#     } else {

#         if (!($Module)) {
#             $PossibleModulename = Get-Item . | Select-Object -ExpandProperty Name
#             $ModuleFile = "$PossibleModulename.psd1"
#             # Write-Verbose $PossibleModulename -Verbose
#             # Write-Verbose $ModuleFile -Verbose
#             if (Test-Path $ModuleFile) {
#                 $Module = $PossibleModulename
#                 Write-Verbose $PossibleModulename -Verbose
#             }
#         }

#         if ($Module) {
#             Import-MyModuleInternal -InternalModule $Module
#         } else {
#             Write-Warning "No module file found in this folder"
#         }
#     }

# }
