Properties {
    # Set this to $true to create a module with a monolithic PSM1
    $PSBPreference.Build.CompileModule = $false
    $PSBPreference.Help.DefaultLocale = 'en-US'
    $PSBPreference.Test.OutputFile = 'out/testResults.xml'
    # $PSBPreference.Test.CodeCoverage.Enabled = $true
    # $PSBPreference.Test.ScriptAnalysisEnabled = $true
}

Task Default -depends Test

Task Test -FromModule PowerShellBuild -minimumVersion '0.6.1'

# Task Build -FromModule PowerShellBuild -Version '0.1.0'
