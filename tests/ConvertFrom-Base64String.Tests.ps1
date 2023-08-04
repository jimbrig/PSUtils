Describe "ConvertFrom-Base64String" {
    BeforeAll {
        Import-Module "${PSScriptRoot}\..\PSUtils\PSUtils.psm1"
        $global:HashTable = "PE9ianMgVmVyc2lvbj0iMS4xLjAuMSIgeG1sbnM9Imh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vcG93ZXJzaGVsbC8yMDA0LzA0Ij4NCiAgPE9iaiBSZWZJZD0iMCI+DQogICAgPFROIFJlZklkPSIwIj4NCiAgICAgIDxUPlN5c3RlbS5Db2xsZWN0aW9ucy5IYXNodGFibGU8L1Q+DQogICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgIDwvVE4+DQogICAgPERDVD4NCiAgICAgIDxFbj4NCiAgICAgICAgPFMgTj0iS2V5Ij5UZXN0PC9TPg0KICAgICAgICA8QiBOPSJWYWx1ZSI+dHJ1ZTwvQj4NCiAgICAgIDwvRW4+DQogICAgPC9EQ1Q+DQogIDwvT2JqPg0KPC9PYmpzPg=="
    }

    Context "Success" {

        It "Pipeline" {
            $Result = $HashTable | ConvertFrom-Base64String
            $Result["Test"] | Should -Be $true
        }

        It "InputObject" {
            $Result = ConvertFrom-Base64String -InputObject $HashTable
            $Result["Test"] | Should -Be $true
        }
    }

    Context "Failure" {
        It "FormatException" {
            $Test = { ConvertFrom-Base64String -InputObject "potato" -ErrorAction Stop }
            $Test | Should -Throw 'The input is not a valid Base-64 string as it contains a non-base 64 character, more than two padding characters, or an illegal character among the padding characters.'
        }
    }

}
