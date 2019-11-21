Describe "Install biome using install.ps1" {
    It "can install the latest version of Biome" {
        components/bio/install.ps1
        $LASTEXITCODE | Should -Be 0
        (Get-Command bio).Path | Should -Be "C:\ProgramData\Biome\bio.exe"
    }

    It "can install a specific version of Biome" {
        components/bio/install.ps1 -v 0.90.6
        $LASTEXITCODE | Should -Be 0

        $result = bio --version
        $result | Should -Match "bio 0.90.6/*"
    }

    It "can install a specific version of Biome from Bintray" {
        components/bio/install.ps1 -v 0.79.1
        $LASTEXITCODE | Should -Be 0

        $result = bio --version
        $result | Should -Match "bio 0.79.1/*"
    }
}
