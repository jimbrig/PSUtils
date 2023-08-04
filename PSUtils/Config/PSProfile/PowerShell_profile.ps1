
# -----------------------------------

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module "$ChocolateyProfile" -ea 0


# -----------------------------------

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

if (Test-Path "$($env:ProgramFiles)\GitHub CLI\gh.exe") {
    Invoke-Expression -Command $(gh completion -s powershell | Out-String) -ea 0
}


# -----------------------------------

Set-Location "\"

# -----------------------------------

Import-Module posh-git -ea 0
if ($GitPromptSettings) {
    $GitPromptSettings.WindowTitle = $false
}

# -----------------------------------

Import-Module DockerCompletion -ea 0
