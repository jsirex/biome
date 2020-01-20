Remove-Item *.tar.gz

function Get-Ident($pkg, $tar) {
    $ident = tar --list --file $tar | ? { $_ -like "hab/pkgs/core/$pkg/**/IDENT" }
    tar --extract --to-stdout --file $tar $ident
}

Describe "bio pkg export tar core/nginx" {
    bio pkg export tar core/nginx --base-pkgs-channel $env:HAB_INTERNAL_BLDR_CHANNEL
    $tar = get-item core-nginx-*.tar.gz
    $version = ((((bio --version) -split " ")[1]) -split "/")[0]
    It "Creates tarball" {
        $tar | Should -Not -Be $null
    }
    It "Includes nginx" {
        Get-Ident nginx $tar | Should -Not -Be $null
    }
    It "Includes bio" {
        Get-Ident bio $tar | Should -BeLike "biome/bio/$version/*"
    }
    It "Includes supervisor" {
        Get-Ident bio-sup $tar | Should -BeLike "biome/bio-sup/$version/*"
    }
    It "Includes launcher" {
        Get-Ident bio-launcher $tar | Should -Not -Be $null
    }
}
