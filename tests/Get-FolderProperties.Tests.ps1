Describe "Get-FolderProperties" {
    BeforeAll {
        Import-Module "${PSScriptRoot}\..\PSUtils\PSUtils.psm1"
        Push-Location -Path "${PSScriptRoot}\Files"

        $ComparatorKB = [pscustomobject] @{
            FullName = (Get-Location -PSProvider FileSystem).ProviderPath
            Length   = 11883864
            Size     = "11,883.86 KB"
            Contains = "7 Files, 0 Folders"
            Created  = "*"
        }

        $ComparatorMiB = [pscustomobject] @{
            FullName = (Get-Location -PSProvider FileSystem).ProviderPath
            Length   = 11883864
            Size     = "11.33 MiB"
            Contains = "7 Files, 0 Folders"
            Created  = "*"
        }
    }

    Context "Success" {
        It "Path" {
            $Test = Get-FolderProperties -Path "."
            $Test | Should -BeLike $ComparatorMiB
        }

        It "LiteralPath" {
            $Test = Get-FolderProperties -LiteralPath "."
            $Test | Should -BeLike $ComparatorMiB
        }

        It "Path & Unit" {
            $Test = Get-FolderProperties -Path "." -Unit KB
            $Test | Should -BeLike $ComparatorKB
        }

        It "LiteralPath & Unit" {
            $Test = Get-FolderProperties -LiteralPath "." -Unit KB
            $Test | Should -BeLike $ComparatorKB
        }
    }

    Context "Failure" {
        It "UnauthorizedAccessException" {
            $Test = { Get-FolderProperties -Path "C:\Config.Msi\" -ErrorAction Stop }
            $Test | Should -Throw "Access to the path 'C:\Config.Msi\' is denied."
        }
    }

    AfterAll {
        Pop-Location
    }
}
