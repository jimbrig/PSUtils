function Install-PSModuleFromGithub {
    <#
    .SYNOPSIS
    A short one-line action-based description, e.g. 'Tests if a function is valid'
    .DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
    .NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
    .LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
    .EXAMPLE
    Install-ModuleFromGithub -Url https://github.com/Something -PSModuleName Something -Headers @{ Authorization = "token 123456789abcdefg" }
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][string] $Url,
        [Parameter(Mandatory)][string] $PSModuleName,
        [Parameter()][string] $Branch = "main",
        [Parameter()][PSCustomObject] $Headers,
        [Parameter()][string] $PSRepoName = "Local",
        [Parameter()][string] $PSRepoPath = "$Env:TEMP\PSRepo"
    )


    if (-not(Test-Path $PSRepoPath)) {
        New-Item $PSRepoPath -ItemType Directory -Force
    }

    $DownloadParams = @{
        Uri     = "$($Url)/archive/refs/heads/$($Branch).zip"
        Headers = $Headers
        OutFile = "$PSRepoPath\repo.zip"
    }

    # Cleanup
    Remove-Item "$($env:TEMP)\$($PSModuleName)" -Recurse -Force
    Remove-Item $DownloadParams.OutFile -Force

    # $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest @DownloadParams -ea stop
    # $ProgressPreference = 'Continue'


    # $PSRepoName = "Local"
    # $PSRepoPath = "C:\Temp\PSrepo"
    # $PSModuleName = "WindowsImaging"
    # $ModulePath = Join-Path -Path $PSRepoPath -ChildPath $PSModuleName


    # Remove-Item $ModulePath -Recurse -Force -ea 0
    Expand-Archive $DownloadParams.OutFile -DestinationPath $env:TEMP -Force


    Rename-Item "$($env:TEMP)\$($PSModuleName)-$($Branch)" -NewName $PSModuleName

    if (-not(Get-PSRepository $PSRepoName -ea 0)) {
        Register-PSRepository -Name $PSRepoName -SourceLocation $PSRepoPath -InstallationPolicy Trusted
    }
    try {
        Publish-Module -Path "$($env:TEMP)\$($PSModuleName)" -Repository $PSRepoName
    } catch {
        Write-Error $_
    }
    Find-Module $PSModuleName -Repository $PSRepoName

    if (Get-Module $PSModuleName -ListAvailable) {
        Update-Module $PSModuleName
    } else {
        Install-Module $PSModuleName -Repository $PSRepoName -Scope AllUsers
    }





}
