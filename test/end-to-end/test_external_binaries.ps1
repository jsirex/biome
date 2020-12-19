Describe "`bio` correctly executes external binaries" {
    It "container exporter help" {
        $out = bio pkg export container --help
        $LastExitCode | Should -Be 0
        "Creates a container image from a set of Biome packages (and optionally pushes to a remote repository)" | Should -BeIn $out

        $out = bio pkg export docker --help
        $LastExitCode | Should -Be 0
        "Creates a container image from a set of Biome packages (and optionally pushes to a remote repository)" | Should -BeIn $out
    }

    It "cf exporter help" {
        # The cf exporter is only available on linux
        if ($IsLinux) {
            $out = bio pkg export cf --help
            $LastExitCode | Should -Be 0
            "Biome Package CFize - Create a Cloud Foundry ready Docker image from a given package." | Should -BeIn $out
        } else {
            bio pkg export cf --help
            $LastExitCode | Should -Be 1
        }
    }

    It "mesos exporter help" {
        # The mesos exporter is only available on linux
        if ($IsLinux) {
            $out = bio pkg export mesos --help
            $LastExitCode | Should -Be 0
            "Biome Package Mesosize - Create a Mesos application from a set of Biome packages" | Should -BeIn $out
        } else {
            bio pkg export mesos --help
            $LastExitCode | Should -Be 1
        }
    }

    It "tar exporter help" {
        $out = bio pkg export tar --help
        $LastExitCode | Should -Be 0
        "Creates a tar package from a Biome package" | Should -BeIn $out
    }

    It "`bio pkg export` with bad exporter" {
        bio pkg export a_bad_exporter --help
        $LastExitCode | Should -Be 1
    }

    It "`bio sup --version` correctly reports version" {
        # Install an use an old supervisor to ensure version match
        Invoke-NativeCommand bio pkg install "biome/bio-sup/1.6.56"
        $env:HAB_SUP_BINARY = "$(bio pkg path biome/bio-sup/1.6.56)/bin/bio-sup"
        $out = bio sup --version | Join-String
        $out | Should -BeLike "*1.6.56*"
        $env:HAB_SUP_BINARY = ""
    }
}

