bio origin key generate $env:HAB_ORIGIN

Function Invoke-WindowsPlanBuild($package) {
    Invoke-NativeCommand bio pkg build test/fixtures/windows_plans/$package -R | Out-Null
    . results/last_build.ps1
    @{ Artifact = $pkg_artifact; Ident = $pkg_ident }
}

Describe "package using scaffolding" {
    $dummy = Invoke-WindowsPlanBuild dummy
    $dummyHabSvcUser = Invoke-WindowsPlanBuild dummy_bio_svc_user
    $scaffolding = Invoke-WindowsPlanBuild scaffolding
    $consumer = Invoke-WindowsPlanBuild use_scaffolding
    It "inherits scaffolding dependencies" {
        bio pkg install "results/$($dummy.Artifact)"
        bio pkg install "results/$($dummyHabSvcUser.Artifact)"
        bio pkg install "results/$($scaffolding.Artifact)"
        bio pkg install "results/$($consumer.Artifact)"
        # scaffolding has dummy as runtime and dummy_bio_svc_user as build time deps

        "/hab/pkgs/$($consumer.Ident)/DEPS" | Should -FileContentMatch "biome-testing/dummy"
        "/hab/pkgs/$($consumer.Ident)/BUILD_DEPS" | Should -FileContentMatch "biome-testing/dummy-bio-user"
    }
}
