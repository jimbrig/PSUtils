Describe "ConvertTo-Base64String" {
    BeforeAll {
        ## SOURCE #############################################################
        Import-Module "${PSScriptRoot}\..\PSUtils\PSUtils.psm1"

        ## SETUP ##############################################################
        $global:HashTable = "PE9ianMgVmVyc2lvbj0iMS4xLjAuMSIgeG1sbnM9Imh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vcG93ZXJzaGVsbC8yMDA0LzA0Ij4NCiAgPE9iaiBSZWZJZD0iMCI+DQogICAgPFROIFJlZklkPSIwIj4NCiAgICAgIDxUPlN5c3RlbS5Db2xsZWN0aW9ucy5IYXNodGFibGU8L1Q+DQogICAgICA8VD5TeXN0ZW0uT2JqZWN0PC9UPg0KICAgIDwvVE4+DQogICAgPERDVD4NCiAgICAgIDxFbj4NCiAgICAgICAgPFMgTj0iS2V5Ij5UZXN0PC9TPg0KICAgICAgICA8QiBOPSJWYWx1ZSI+dHJ1ZTwvQj4NCiAgICAgIDwvRW4+DQogICAgPC9EQ1Q+DQogIDwvT2JqPg0KPC9PYmpzPg=="
    }

    ## SUCCESS ################################################################
    Context "Success" {
        It "Pipeline" {
            $Result = @{ Test = $true } | ConvertTo-Base64String
            $Result | Should -Be $HashTable
        }

        It "InputObject" {
            $Result = ConvertTo-Base64String -InputObject @{ Test = $true }
            $Result | Should -Be $HashTable
        }
    }

    ## FAILURE ################################################################
    Context "Failure" {
    }
}
