use crate::cli;
use clap::App;
use biome_common::FeatureFlag;
use std::str;

fn no_feature_flags() -> FeatureFlag { FeatureFlag::empty() }

fn config_file_enabled() -> FeatureFlag {
    let mut f = FeatureFlag::empty();
    f.insert(FeatureFlag::CONFIG_FILE);
    f
}

fn help(app: &App) -> String {
    let mut help = Vec::new();
    app.write_help(&mut help).expect("to write help");
    String::from(str::from_utf8(&help).expect("to convert help to utf8"))
}

fn sub<'a>(app: &'a App, name: &str) -> &'a App<'a, 'a> {
    app.p
       .subcommands()
       .find(|s| s.p.meta.name == name)
       .unwrap_or_else(|| panic!("expected to find subcommand '{}'", name))
}

// Manually verify the structopt output of each subcommand. This manual method is useful for
// determining exactly which subcommand is different. Whereas `bio_help_recursive` test all
// the subcommands it is hard to determine exactly which subcommand is different.
#[test]
#[allow(clippy::cognitive_complexity)]
fn bio_help_manual() {
    // bio
    let bio1 = cli::get(no_feature_flags()).after_help("");
    let bio2 = cli::get(config_file_enabled()).after_help("");
    let help1 = help(&bio1);
    let help2 = help(&bio2);
    assert_eq!(help1, help2);

    // bio license
    let bio_license1 = sub(&bio1, "license");
    let bio_license2 = sub(&bio2, "license");
    let help1 = help(bio_license1);
    let help2 = help(bio_license2);
    assert_eq!(help1, help2);

    // bio license accept
    let bio_license_accept1 = sub(&bio_license1, "accept");
    let bio_license_accept2 = sub(&bio_license2, "accept");
    let help1 = help(bio_license_accept1);
    let help2 = help(bio_license_accept2);
    assert_eq!(help1, help2);

    // bio cli
    let bio_cli1 = sub(&bio1, "cli");
    let bio_cli2 = sub(&bio2, "cli");
    let help1 = help(bio_cli1);
    let help2 = help(bio_cli2);
    assert_eq!(help1, help2);

    // bio cli completers
    let bio_cli_completers1 = sub(&bio_cli1, "completers");
    let bio_cli_completers2 = sub(&bio_cli2, "completers");
    let help1 = help(bio_cli_completers1);
    let help2 = help(bio_cli_completers2);
    assert_eq!(help1, help2);

    // bio cli setup
    let bio_cli_setup1 = sub(&bio_cli1, "setup");
    let bio_cli_setup2 = sub(&bio_cli2, "setup");
    let help1 = help(bio_cli_setup1);
    let help2 = help(bio_cli_setup2);
    assert_eq!(help1, help2);

    // bio bldr
    let bio_bldr1 = sub(&bio1, "bldr");
    let bio_bldr2 = sub(&bio2, "bldr");
    let help1 = help(bio_bldr1);
    let help2 = help(bio_bldr2);
    assert_eq!(help1, help2);

    // bio bldr channel
    let bio_bldr_channel1 = sub(&bio_bldr1, "channel");
    let bio_bldr_channel2 = sub(&bio_bldr2, "channel");
    let help1 = help(bio_bldr_channel1);
    let help2 = help(bio_bldr_channel2);
    assert_eq!(help1, help2);

    // bio bldr channel create
    let bio_bldr_channel_create1 = sub(&bio_bldr_channel1, "create");
    let bio_bldr_channel_create2 = sub(&bio_bldr_channel2, "create");
    let help1 = help(bio_bldr_channel_create1);
    let help2 = help(bio_bldr_channel_create2);
    assert_eq!(help1, help2);

    // bio bldr channel demote
    let bio_bldr_channel_demote1 = sub(&bio_bldr_channel1, "demote");
    let bio_bldr_channel_demote2 = sub(&bio_bldr_channel2, "demote");
    let help1 = help(bio_bldr_channel_demote1);
    let help2 = help(bio_bldr_channel_demote2);
    assert_eq!(help1, help2);

    // bio bldr channel destroy
    let bio_bldr_channel_destroy1 = sub(&bio_bldr_channel1, "destroy");
    let bio_bldr_channel_destroy2 = sub(&bio_bldr_channel2, "destroy");
    let help1 = help(bio_bldr_channel_destroy1);
    let help2 = help(bio_bldr_channel_destroy2);
    assert_eq!(help1, help2);

    // bio bldr channel list
    let bio_bldr_channel_list1 = sub(&bio_bldr_channel1, "list");
    let bio_bldr_channel_list2 = sub(&bio_bldr_channel2, "list");
    let help1 = help(bio_bldr_channel_list1);
    let help2 = help(bio_bldr_channel_list2);
    assert_eq!(help1, help2);

    // bio bldr channel promote
    let bio_bldr_channel_promote1 = sub(&bio_bldr_channel1, "promote");
    let bio_bldr_channel_promote2 = sub(&bio_bldr_channel2, "promote");
    let help1 = help(bio_bldr_channel_promote1);
    let help2 = help(bio_bldr_channel_promote2);
    assert_eq!(help1, help2);

    // bio bldr job
    let bio_bldr_job1 = sub(&bio_bldr1, "job");
    let bio_bldr_job2 = sub(&bio_bldr2, "job");
    let help1 = help(bio_bldr_job1);
    let help2 = help(bio_bldr_job2);
    assert_eq!(help1, help2);

    // bio bldr job cancel
    let bio_bldr_job_cancel1 = sub(&bio_bldr_job1, "cancel");
    let bio_bldr_job_cancel2 = sub(&bio_bldr_job2, "cancel");
    let help1 = help(bio_bldr_job_cancel1);
    let help2 = help(bio_bldr_job_cancel2);
    assert_eq!(help1, help2);

    // bio bldr job demote
    let bio_bldr_job_demote1 = sub(&bio_bldr_job1, "demote");
    let bio_bldr_job_demote2 = sub(&bio_bldr_job2, "demote");
    let help1 = help(bio_bldr_job_demote1);
    let help2 = help(bio_bldr_job_demote2);
    assert_eq!(help1, help2);

    // bio bldr job promote
    let bio_bldr_job_promote1 = sub(&bio_bldr_job1, "promote");
    let bio_bldr_job_promote2 = sub(&bio_bldr_job2, "promote");
    let help1 = help(bio_bldr_job_promote1);
    let help2 = help(bio_bldr_job_promote2);
    assert_eq!(help1, help2);

    // bio bldr job start
    let bio_bldr_job_start1 = sub(&bio_bldr_job1, "start");
    let bio_bldr_job_start2 = sub(&bio_bldr_job2, "start");
    let help1 = help(bio_bldr_job_start1);
    let help2 = help(bio_bldr_job_start2);
    assert_eq!(help1, help2);

    // bio bldr job start
    let bio_bldr_job_status1 = sub(&bio_bldr_job1, "status");
    let bio_bldr_job_status2 = sub(&bio_bldr_job2, "status");
    let help1 = help(bio_bldr_job_status1);
    let help2 = help(bio_bldr_job_status2);
    assert_eq!(help1, help2);

    // bio config
    let bio_config1 = sub(&bio1, "config");
    let bio_config2 = sub(&bio2, "config");
    let help1 = help(bio_config1);
    let help2 = help(bio_config2);
    assert_eq!(help1, help2);

    // bio config apply
    let bio_config_apply1 = sub(&bio_config1, "apply");
    let bio_config_apply2 = sub(&bio_config2, "apply");
    let help1 = help(bio_config_apply1);
    let help2 = help(bio_config_apply2);
    assert_eq!(help1, help2);

    // bio config show
    let bio_config_show1 = sub(&bio_config1, "show");
    let bio_config_show2 = sub(&bio_config2, "show");
    let help1 = help(bio_config_show1);
    let help2 = help(bio_config_show2);
    assert_eq!(help1, help2);

    // bio file
    let bio_file1 = sub(&bio1, "file");
    let bio_file2 = sub(&bio2, "file");
    let help1 = help(bio_file1);
    let help2 = help(bio_file2);
    assert_eq!(help1, help2);

    // bio file upload
    let bio_file_upload1 = sub(&bio_file1, "upload");
    let bio_file_upload2 = sub(&bio_file2, "upload");
    let help1 = help(bio_file_upload1);
    let help2 = help(bio_file_upload2);
    assert_eq!(help1, help2);

    // bio origin
    let bio_origin1 = sub(&bio1, "origin");
    let bio_origin2 = sub(&bio2, "origin");
    let help1 = help(bio_origin1);
    let help2 = help(bio_origin2);
    assert_eq!(help1, help2);

    // bio origin create
    let bio_origin_create1 = sub(&bio_origin1, "create");
    let bio_origin_create2 = sub(&bio_origin2, "create");
    let help1 = help(bio_origin_create1);
    let help2 = help(bio_origin_create2);
    assert_eq!(help1, help2);

    // bio origin delete
    let bio_origin_delete1 = sub(&bio_origin1, "delete");
    let bio_origin_delete2 = sub(&bio_origin2, "delete");
    let help1 = help(bio_origin_delete1);
    let help2 = help(bio_origin_delete2);
    assert_eq!(help1, help2);

    // bio origin depart
    let bio_origin_depart1 = sub(&bio_origin1, "depart");
    let bio_origin_depart2 = sub(&bio_origin2, "depart");
    let help1 = help(bio_origin_depart1);
    let help2 = help(bio_origin_depart2);
    assert_eq!(help1, help2);

    // bio origin invitations
    let bio_origin_invitations1 = sub(&bio_origin1, "invitations");
    let bio_origin_invitations2 = sub(&bio_origin2, "invitations");
    let help1 = help(bio_origin_invitations1);
    let help2 = help(bio_origin_invitations2);
    assert_eq!(help1, help2);

    // bio origin invitations accept
    let bio_origin_invitations_accept1 = sub(&bio_origin_invitations1, "accept");
    let bio_origin_invitations_accept2 = sub(&bio_origin_invitations2, "accept");
    let help1 = help(bio_origin_invitations_accept1);
    let help2 = help(bio_origin_invitations_accept2);
    assert_eq!(help1, help2);

    // bio origin invitations ignore
    let bio_origin_invitations_ignore1 = sub(&bio_origin_invitations1, "ignore");
    let bio_origin_invitations_ignore2 = sub(&bio_origin_invitations2, "ignore");
    let help1 = help(bio_origin_invitations_ignore1);
    let help2 = help(bio_origin_invitations_ignore2);
    assert_eq!(help1, help2);

    // bio origin invitations list
    let bio_origin_invitations_list1 = sub(&bio_origin_invitations1, "list");
    let bio_origin_invitations_list2 = sub(&bio_origin_invitations2, "list");
    let help1 = help(bio_origin_invitations_list1);
    let help2 = help(bio_origin_invitations_list2);
    assert_eq!(help1, help2);

    // bio origin invitations pending
    let bio_origin_invitations_pending1 = sub(&bio_origin_invitations1, "pending");
    let bio_origin_invitations_pending2 = sub(&bio_origin_invitations2, "pending");
    let help1 = help(bio_origin_invitations_pending1);
    let help2 = help(bio_origin_invitations_pending2);
    assert_eq!(help1, help2);

    // bio origin invitations rescind
    let bio_origin_invitations_rescind1 = sub(&bio_origin_invitations1, "rescind");
    let bio_origin_invitations_rescind2 = sub(&bio_origin_invitations2, "rescind");
    let help1 = help(bio_origin_invitations_rescind1);
    let help2 = help(bio_origin_invitations_rescind2);
    assert_eq!(help1, help2);

    // bio origin invitations send
    let bio_origin_invitations_send1 = sub(&bio_origin_invitations1, "send");
    let bio_origin_invitations_send2 = sub(&bio_origin_invitations2, "send");
    let help1 = help(bio_origin_invitations_send1);
    let help2 = help(bio_origin_invitations_send2);
    assert_eq!(help1, help2);

    // bio origin key
    let bio_origin_key1 = sub(&bio_origin1, "key");
    let bio_origin_key2 = sub(&bio_origin2, "key");
    let help1 = help(bio_origin_key1);
    let help2 = help(bio_origin_key2);
    assert_eq!(help1, help2);

    // bio origin key download
    let bio_origin_key_download1 = sub(&bio_origin_key1, "download");
    let bio_origin_key_download2 = sub(&bio_origin_key2, "download");
    let help1 = help(bio_origin_key_download1);
    let help2 = help(bio_origin_key_download2);
    assert_eq!(help1, help2);

    // bio origin key export
    let bio_origin_key_export1 = sub(&bio_origin_key1, "export");
    let bio_origin_key_export2 = sub(&bio_origin_key2, "export");
    let help1 = help(bio_origin_key_export1);
    let help2 = help(bio_origin_key_export2);
    assert_eq!(help1, help2);

    // bio origin key generate
    let bio_origin_key_generate1 = sub(&bio_origin_key1, "generate");
    let bio_origin_key_generate2 = sub(&bio_origin_key2, "generate");
    let help1 = help(bio_origin_key_generate1);
    let help2 = help(bio_origin_key_generate2);
    assert_eq!(help1, help2);

    // bio origin key import
    let bio_origin_key_import1 = sub(&bio_origin_key1, "import");
    let bio_origin_key_import2 = sub(&bio_origin_key2, "import");
    let help1 = help(bio_origin_key_import1);
    let help2 = help(bio_origin_key_import2);
    assert_eq!(help1, help2);

    // bio origin key upload
    let bio_origin_key_upload1 = sub(&bio_origin_key1, "upload");
    let bio_origin_key_upload2 = sub(&bio_origin_key2, "upload");
    let help1 = help(bio_origin_key_upload1);
    let help2 = help(bio_origin_key_upload2);
    assert_eq!(help1, help2);

    // bio origin secret
    let bio_origin_secret1 = sub(&bio_origin1, "secret");
    let bio_origin_secret2 = sub(&bio_origin2, "secret");
    let help1 = help(bio_origin_secret1);
    let help2 = help(bio_origin_secret2);
    assert_eq!(help1, help2);

    // bio origin secret delete
    let bio_origin_secret_delete1 = sub(&bio_origin_secret1, "delete");
    let bio_origin_secret_delete2 = sub(&bio_origin_secret2, "delete");
    let help1 = help(bio_origin_secret_delete1);
    let help2 = help(bio_origin_secret_delete2);
    assert_eq!(help1, help2);

    // bio origin secret list
    let bio_origin_secret_list1 = sub(&bio_origin_secret1, "list");
    let bio_origin_secret_list2 = sub(&bio_origin_secret2, "list");
    let help1 = help(bio_origin_secret_list1);
    let help2 = help(bio_origin_secret_list2);
    assert_eq!(help1, help2);

    // bio origin secret upload
    let bio_origin_secret_upload1 = sub(&bio_origin_secret1, "upload");
    let bio_origin_secret_upload2 = sub(&bio_origin_secret2, "upload");
    let help1 = help(bio_origin_secret_upload1);
    let help2 = help(bio_origin_secret_upload2);
    assert_eq!(help1, help2);

    // bio origin transfer
    let bio_origin_transfer1 = sub(&bio_origin1, "transfer");
    let bio_origin_transfer2 = sub(&bio_origin2, "transfer");
    let help1 = help(bio_origin_transfer1);
    let help2 = help(bio_origin_transfer2);
    assert_eq!(help1, help2);

    // bio pkg
    let bio_pkg1 = sub(&bio1, "pkg");
    let bio_pkg2 = sub(&bio2, "pkg");
    let help1 = help(bio_pkg1);
    let help2 = help(bio_pkg2);
    assert_eq!(help1, help2);

    // bio pkg binds
    let bio_pkg_binds1 = sub(&bio_pkg1, "binds");
    let bio_pkg_binds2 = sub(&bio_pkg2, "binds");
    let help1 = help(bio_pkg_binds1);
    let help2 = help(bio_pkg_binds2);
    assert_eq!(help1, help2);

    // bio pkg binlink
    let bio_pkg_binlink1 = sub(&bio_pkg1, "binlink");
    let bio_pkg_binlink2 = sub(&bio_pkg2, "binlink");
    let help1 = help(bio_pkg_binlink1);
    let help2 = help(bio_pkg_binlink2);
    assert_eq!(help1, help2);

    // bio pkg build
    let bio_pkg_build1 = sub(&bio_pkg1, "build");
    let bio_pkg_build2 = sub(&bio_pkg2, "build");
    let help1 = help(bio_pkg_build1);
    let help2 = help(bio_pkg_build2);
    assert_eq!(help1, help2);

    // bio pkg bulkupload
    let bio_pkg_bulkupload1 = sub(&bio_pkg1, "bulkupload");
    let bio_pkg_bulkupload2 = sub(&bio_pkg2, "bulkupload");
    let help1 = help(bio_pkg_bulkupload1);
    let help2 = help(bio_pkg_bulkupload2);
    assert_eq!(help1, help2);

    // bio pkg channels
    let bio_pkg_channels1 = sub(&bio_pkg1, "channels");
    let bio_pkg_channels2 = sub(&bio_pkg2, "channels");
    let help1 = help(bio_pkg_channels1);
    let help2 = help(bio_pkg_channels2);
    assert_eq!(help1, help2);

    // bio pkg config
    let bio_pkg_config1 = sub(&bio_pkg1, "config");
    let bio_pkg_config2 = sub(&bio_pkg2, "config");
    let help1 = help(bio_pkg_config1);
    let help2 = help(bio_pkg_config2);
    assert_eq!(help1, help2);

    // bio pkg delete
    let bio_pkg_delete1 = sub(&bio_pkg1, "delete");
    let bio_pkg_delete2 = sub(&bio_pkg2, "delete");
    let help1 = help(bio_pkg_delete1);
    let help2 = help(bio_pkg_delete2);
    assert_eq!(help1, help2);

    // bio pkg demote
    let bio_pkg_demote1 = sub(&bio_pkg1, "demote");
    let bio_pkg_demote2 = sub(&bio_pkg2, "demote");
    let help1 = help(bio_pkg_demote1);
    let help2 = help(bio_pkg_demote2);
    assert_eq!(help1, help2);

    // bio pkg dependencies
    let bio_pkg_dependencies1 = sub(&bio_pkg1, "dependencies");
    let bio_pkg_dependencies2 = sub(&bio_pkg2, "dependencies");
    let help1 = help(bio_pkg_dependencies1);
    let help2 = help(bio_pkg_dependencies2);
    assert_eq!(help1, help2);

    // bio pkg download
    let bio_pkg_download1 = sub(&bio_pkg1, "download");
    let bio_pkg_download2 = sub(&bio_pkg2, "download");
    let help1 = help(bio_pkg_download1);
    let help2 = help(bio_pkg_download2);
    assert_eq!(help1, help2);

    // bio pkg env
    let bio_pkg_env1 = sub(&bio_pkg1, "env");
    let bio_pkg_env2 = sub(&bio_pkg2, "env");
    let help1 = help(bio_pkg_env1);
    let help2 = help(bio_pkg_env2);
    assert_eq!(help1, help2);

    // bio pkg exec
    let bio_pkg_exec1 = sub(&bio_pkg1, "exec");
    let bio_pkg_exec2 = sub(&bio_pkg2, "exec");
    let help1 = help(bio_pkg_exec1);
    let help2 = help(bio_pkg_exec2);
    assert_eq!(help1, help2);

    // bio pkg export
    let bio_pkg_export1 = sub(&bio_pkg1, "export");
    let bio_pkg_export2 = sub(&bio_pkg2, "export");
    let help1 = help(bio_pkg_export1);
    let help2 = help(bio_pkg_export2);
    assert_eq!(help1, help2);

    // bio pkg hash
    let bio_pkg_hash1 = sub(&bio_pkg1, "hash");
    let bio_pkg_hash2 = sub(&bio_pkg2, "hash");
    let help1 = help(bio_pkg_hash1);
    let help2 = help(bio_pkg_hash2);
    assert_eq!(help1, help2);

    // bio pkg info
    let bio_pkg_info1 = sub(&bio_pkg1, "info");
    let bio_pkg_info2 = sub(&bio_pkg2, "info");
    let help1 = help(bio_pkg_info1);
    let help2 = help(bio_pkg_info2);
    assert_eq!(help1, help2);

    // bio pkg install
    let bio_pkg_install1 = sub(&bio_pkg1, "install");
    let bio_pkg_install2 = sub(&bio_pkg2, "install");
    let help1 = help(bio_pkg_install1);
    let help2 = help(bio_pkg_install2);
    assert_eq!(help1, help2);

    // bio pkg list
    let bio_pkg_list1 = sub(&bio_pkg1, "list");
    let bio_pkg_list2 = sub(&bio_pkg2, "list");
    let help1 = help(bio_pkg_list1);
    let help2 = help(bio_pkg_list2);
    assert_eq!(help1, help2);

    // bio pkg path
    let bio_pkg_path1 = sub(&bio_pkg1, "path");
    let bio_pkg_path2 = sub(&bio_pkg2, "path");
    let help1 = help(bio_pkg_path1);
    let help2 = help(bio_pkg_path2);
    assert_eq!(help1, help2);

    // bio pkg promote
    let bio_pkg_promote1 = sub(&bio_pkg1, "promote");
    let bio_pkg_promote2 = sub(&bio_pkg2, "promote");
    let help1 = help(bio_pkg_promote1);
    let help2 = help(bio_pkg_promote2);
    assert_eq!(help1, help2);

    // bio pkg provides
    let bio_pkg_provides1 = sub(&bio_pkg1, "provides");
    let bio_pkg_provides2 = sub(&bio_pkg2, "provides");
    let help1 = help(bio_pkg_provides1);
    let help2 = help(bio_pkg_provides2);
    assert_eq!(help1, help2);

    // bio pkg search
    let bio_pkg_search1 = sub(&bio_pkg1, "search");
    let bio_pkg_search2 = sub(&bio_pkg2, "search");
    let help1 = help(bio_pkg_search1);
    let help2 = help(bio_pkg_search2);
    assert_eq!(help1, help2);

    // bio pkg sign
    let bio_pkg_sign1 = sub(&bio_pkg1, "sign");
    let bio_pkg_sign2 = sub(&bio_pkg2, "sign");
    let help1 = help(bio_pkg_sign1);
    let help2 = help(bio_pkg_sign2);
    assert_eq!(help1, help2);

    // bio pkg uninstall
    let bio_pkg_uninstall1 = sub(&bio_pkg1, "uninstall");
    let bio_pkg_uninstall2 = sub(&bio_pkg2, "uninstall");
    let help1 = help(bio_pkg_uninstall1);
    let help2 = help(bio_pkg_uninstall2);
    assert_eq!(help1, help2);

    // bio pkg upload
    let bio_pkg_upload1 = sub(&bio_pkg1, "upload");
    let bio_pkg_upload2 = sub(&bio_pkg2, "upload");
    let help1 = help(bio_pkg_upload1);
    let help2 = help(bio_pkg_upload2);
    assert_eq!(help1, help2);

    // bio pkg verify
    let bio_pkg_verify1 = sub(&bio_pkg1, "verify");
    let bio_pkg_verify2 = sub(&bio_pkg2, "verify");
    let help1 = help(bio_pkg_verify1);
    let help2 = help(bio_pkg_verify2);
    assert_eq!(help1, help2);

    // bio plan
    let bio_plan1 = sub(&bio1, "plan");
    let bio_plan2 = sub(&bio2, "plan");
    let help1 = help(bio_plan1);
    let help2 = help(bio_plan2);
    assert_eq!(help1, help2);

    // bio plan init
    let bio_plan_init1 = sub(&bio_plan1, "init");
    let bio_plan_init2 = sub(&bio_plan2, "init");
    let help1 = help(bio_plan_init1);
    let help2 = help(bio_plan_init2);
    assert_eq!(help1, help2);

    // bio plan render
    let bio_plan_render1 = sub(&bio_plan1, "render");
    let bio_plan_render2 = sub(&bio_plan2, "render");
    let help1 = help(bio_plan_render1);
    let help2 = help(bio_plan_render2);
    assert_eq!(help1, help2);

    // bio ring
    let bio_ring1 = sub(&bio1, "ring");
    let bio_ring2 = sub(&bio2, "ring");
    let help1 = help(bio_ring1);
    let help2 = help(bio_ring2);
    assert_eq!(help1, help2);

    // bio ring key
    let bio_ring_key1 = sub(&bio_ring1, "key");
    let bio_ring_key2 = sub(&bio_ring2, "key");
    let help1 = help(bio_ring_key1);
    let help2 = help(bio_ring_key2);
    assert_eq!(help1, help2);

    // bio ring key export
    let bio_ring_key_export1 = sub(&bio_ring_key1, "export");
    let bio_ring_key_export2 = sub(&bio_ring_key2, "export");
    let help1 = help(bio_ring_key_export1);
    let help2 = help(bio_ring_key_export2);
    assert_eq!(help1, help2);

    // bio ring key generate
    let bio_ring_key_generate1 = sub(&bio_ring_key1, "generate");
    let bio_ring_key_generate2 = sub(&bio_ring_key2, "generate");
    let help1 = help(bio_ring_key_generate1);
    let help2 = help(bio_ring_key_generate2);
    assert_eq!(help1, help2);

    // bio ring key import
    let bio_ring_key_import1 = sub(&bio_ring_key1, "import");
    let bio_ring_key_import2 = sub(&bio_ring_key2, "import");
    let help1 = help(bio_ring_key_import1);
    let help2 = help(bio_ring_key_import2);
    assert_eq!(help1, help2);

    // bio studio
    let bio_studio1 = sub(&bio1, "studio");
    let bio_studio2 = sub(&bio2, "studio");
    let help1 = help(bio_studio1);
    let help2 = help(bio_studio2);
    assert_eq!(help1, help2);

    // bio sup
    let bio_sup1 = sub(&bio1, "sup");
    let bio_sup2 = sub(&bio2, "sup");
    let help1 = help(bio_sup1);
    let help2 = help(bio_sup2);
    assert_eq!(help1, help2);

    // bio sup bash
    let bio_sup_bash1 = sub(&bio_sup1, "bash");
    let bio_sup_bash2 = sub(&bio_sup2, "bash");
    let help1 = help(bio_sup_bash1);
    let help2 = help(bio_sup_bash2);
    assert_eq!(help1, help2);

    // bio sup depart
    let bio_sup_depart1 = sub(&bio_sup1, "depart");
    let bio_sup_depart2 = sub(&bio_sup2, "depart");
    let help1 = help(bio_sup_depart1);
    let help2 = help(bio_sup_depart2);
    assert_eq!(help1, help2);

    // bio sup run
    let bio_sup_run1 = sub(&bio_sup1, "run");
    let bio_sup_run2 = sub(&bio_sup2, "run");
    let help1 = help(bio_sup_run1);
    let help2 = help(bio_sup_run2);
    assert_eq!(help1, help2);

    // bio sup secret
    let bio_sup_secret1 = sub(&bio_sup1, "secret");
    let bio_sup_secret2 = sub(&bio_sup2, "secret");
    let help1 = help(bio_sup_secret1);
    let help2 = help(bio_sup_secret2);
    assert_eq!(help1, help2);

    // bio sup sh
    let bio_sup_sh1 = sub(&bio_sup1, "sh");
    let bio_sup_sh2 = sub(&bio_sup2, "sh");
    let help1 = help(bio_sup_sh1);
    let help2 = help(bio_sup_sh2);
    assert_eq!(help1, help2);

    // bio sup status
    let bio_sup_status1 = sub(&bio_sup1, "status");
    let bio_sup_status2 = sub(&bio_sup2, "status");
    let help1 = help(bio_sup_status1);
    let help2 = help(bio_sup_status2);
    assert_eq!(help1, help2);

    // bio sup term
    let bio_sup_term1 = sub(&bio_sup1, "term");
    let bio_sup_term2 = sub(&bio_sup2, "term");
    let help1 = help(bio_sup_term1);
    let help2 = help(bio_sup_term2);
    assert_eq!(help1, help2);

    // bio supportbundle
    let bio_supportbundle1 = sub(&bio1, "supportbundle");
    let bio_supportbundle2 = sub(&bio2, "supportbundle");
    let help1 = help(bio_supportbundle1);
    let help2 = help(bio_supportbundle2);
    assert_eq!(help1, help2);

    // bio svc
    let bio_svc1 = sub(&bio1, "svc");
    let bio_svc2 = sub(&bio2, "svc");
    let help1 = help(bio_svc1);
    let help2 = help(bio_svc2);
    assert_eq!(help1, help2);

    // bio svc key
    let bio_svc_key1 = sub(&bio_svc1, "key");
    let bio_svc_key2 = sub(&bio_svc2, "key");
    let help1 = help(bio_svc_key1);
    let help2 = help(bio_svc_key2);
    assert_eq!(help1, help2);

    // bio svc key generate
    let bio_svc_key_generate1 = sub(&bio_svc_key1, "generate");
    let bio_svc_key_generate2 = sub(&bio_svc_key2, "generate");
    let help1 = help(bio_svc_key_generate1);
    let help2 = help(bio_svc_key_generate2);
    assert_eq!(help1, help2);

    // bio svc load
    let bio_svc_load1 = sub(&bio_svc1, "load");
    let bio_svc_load2 = sub(&bio_svc2, "load");
    let help1 = help(bio_svc_load1);
    let help2 = help(bio_svc_load2);
    assert_eq!(help1, help2);

    // bio svc start
    let bio_svc_start1 = sub(&bio_svc1, "start");
    let bio_svc_start2 = sub(&bio_svc2, "start");
    let help1 = help(bio_svc_start1);
    let help2 = help(bio_svc_start2);
    assert_eq!(help1, help2);

    // bio svc status
    let bio_svc_status1 = sub(&bio_svc1, "status");
    let bio_svc_status2 = sub(&bio_svc2, "status");
    let help1 = help(bio_svc_status1);
    let help2 = help(bio_svc_status2);
    assert_eq!(help1, help2);

    // bio svc stop
    let bio_svc_stop1 = sub(&bio_svc1, "stop");
    let bio_svc_stop2 = sub(&bio_svc2, "stop");
    let help1 = help(bio_svc_stop1);
    let help2 = help(bio_svc_stop2);
    assert_eq!(help1, help2);

    // bio svc unload
    let bio_svc_unload1 = sub(&bio_svc1, "unload");
    let bio_svc_unload2 = sub(&bio_svc2, "unload");
    let help1 = help(bio_svc_unload1);
    let help2 = help(bio_svc_unload2);
    assert_eq!(help1, help2);

    // hab user
    let bio_user1 = sub(&bio1, "user");
    let bio_user2 = sub(&bio2, "user");
    let help1 = help(bio_user1);
    let help2 = help(bio_user2);
    assert_eq!(help1, help2);

    // bio user key
    let bio_user_key1 = sub(&bio_user1, "key");
    let bio_user_key2 = sub(&bio_user2, "key");
    let help1 = help(bio_user_key1);
    let help2 = help(bio_user_key2);
    assert_eq!(help1, help2);

    // bio user key generate
    let bio_user_key_generate1 = sub(&bio_user_key1, "generate");
    let bio_user_key_generate2 = sub(&bio_user_key2, "generate");
    let help1 = help(bio_user_key_generate1);
    let help2 = help(bio_user_key_generate2);
    assert_eq!(help1, help2);
}

// Recursivly verify the structopt output of each subcommand
#[test]
fn bio_help_recursive() {
    let mut bio1 = cli::get(no_feature_flags()).after_help("");
    bio1.p.subcommands.truncate(hab1.p.subcommands.len() - 7);
    let bio2 = cli::get(config_file_enabled()).after_help("");
    fn compare(app1: &App, app2: &App) {
        let help1 = help(app1);
        let help2 = help(app2);
        assert_eq!(help1, help2);
        assert_eq!(app1.p.subcommands.len(), app2.p.subcommands.len());
        for sub1 in app1.p.subcommands() {
            let name = &sub1.p.meta.name;
            let sub2 = sub(app2, name);
            compare(sub1, sub2);
        }
    }
    compare(&bio1, &bio2);
}

#[test]
fn sup_run_help() {
    let sup1 = cli::sub_sup_run(no_feature_flags()).after_help("");
    let sup2 = cli::sub_sup_run(config_file_enabled()).after_help("");
    let help1 = help(&sup1);
    let help2 = help(&sup2);
    assert_eq!(help1, help2);
}
