# This tests that the version of bio that we are releaseing is the same 
# version embedded in the studio package. Since the studio is built 
# with the previous version of `bio` this is useful to verify that the
# correct version was copied.
 
Describe "Studio bio cli version" {
    bio origin key generate "$env:HAB_ORIGIN"
    $expected_version = $(bio --version)

    It "matches the version of the studio" {
        $result = Invoke-StudioRun "bio --version"
        $result[-1] | Should -Be $expected_version
    }
}

