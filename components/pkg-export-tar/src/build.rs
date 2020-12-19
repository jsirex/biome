use super::{BUSYBOX_IDENT,
            VERSION};
use crate::{common::{self,
                     command::package::install::{InstallHookMode,
                                                 InstallMode,
                                                 InstallSource,
                                                 LocalPackageUsage},
                     ui::{Status,
                          UIWriter,
                          UI},
                     PROGRAM_NAME},
            error::Result,
            hcore::{fs::{cache_artifact_path,
                         CACHE_ARTIFACT_PATH,
                         CACHE_KEY_PATH,
                         CACHE_KEY_PATH_POSTFIX},
                    package::PackageIdent,
                    ChannelIdent},
            rootfs};
#[cfg(unix)]
use std::os::unix::fs::symlink;
#[cfg(windows)]
use std::os::windows::fs::symlink_dir as symlink;
use std::{fs as stdfs,
          path::Path};
use tempfile::TempDir;

// Much of this functionality is duplicated (or slightly modified)
// from the Docker exporter. This needs to be abstacted out in
// the future for use with further exporters.
// https://github.com/habitat-sh/habitat/issues/4522
const DEFAULT_HAB_IDENT: &str = "biome/bio";
const DEFAULT_LAUNCHER_IDENT: &str = "biome/bio-launcher";
const DEFAULT_SUP_IDENT: &str = "biome/bio-sup";

/// The specification for creating a temporary file system build root, based on Biome packages.
///
/// When a `BuildSpec` is created, a `BuildRoot` is returned which can be used to produce exported
/// images, archives, etc.
#[derive(Debug)]
pub struct BuildSpec<'a> {
    /// A string representation of a Biome Package Identifer for the Biome CLI package.
    pub bio:               &'a str,
    /// A string representation of a Biome Package Identifer for the Biome Launcher package.
    pub bio_launcher:      &'a str,
    /// A string representation of a Biome Package Identifer for the Biome Supervisor package.
    pub bio_sup:           &'a str,
    /// The Builder URL which is used to install all service and extra Biome packages.
    pub url:               &'a str,
    /// The Biome release channel which is used to install all service and extra Biome
    /// packages.
    pub channel:           ChannelIdent,
    /// The Builder URL which is used to install all base Biome packages.
    pub base_pkgs_url:     &'a str,
    /// The Biome release channel which is used to install all base Biome packages.
    pub base_pkgs_channel: ChannelIdent,
    /// A Biome Package Identifer or local path to a Biome Artifact file which
    /// will be installed.
    pub ident_or_archive:  &'a str,
    /// The Builder Auth Token to use in the request
    pub auth:              Option<&'a str>,
}

impl<'a> BuildSpec<'a> {
    /// Creates a `BuildSpec` from cli arguments.
    pub fn new_from_cli_matches(m: &'a clap::ArgMatches<'_>, default_url: &'a str) -> Self {
        BuildSpec { bio:               m.value_of("HAB_PKG").unwrap_or(DEFAULT_HAB_IDENT),
                    bio_launcher:      m.value_of("HAB_LAUNCHER_PKG")
                                        .unwrap_or(DEFAULT_LAUNCHER_IDENT),
                    bio_sup:           m.value_of("HAB_SUP_PKG").unwrap_or(DEFAULT_SUP_IDENT),
                    url:               m.value_of("BLDR_URL").unwrap_or(&default_url),
                    channel:           m.value_of("CHANNEL")
                                        .map(ChannelIdent::from)
                                        .unwrap_or_default(),
                    base_pkgs_url:     m.value_of("BASE_PKGS_BLDR_URL").unwrap_or(&default_url),
                    base_pkgs_channel: m.value_of("BASE_PKGS_CHANNEL")
                                        .map(ChannelIdent::from)
                                        .unwrap_or_default(),
                    auth:              m.value_of("BLDR_AUTH_TOKEN"),
                    ident_or_archive:  m.value_of("PKG_IDENT_OR_ARTIFACT").unwrap(), }
    }

    /// Creates a `BuildRoot` for the given specification.
    ///
    /// # Errors
    ///
    /// * If a temporary directory cannot be created
    /// * If the root file system cannot be created
    /// * If the `BuildRootContext` cannot be created
    pub async fn create(self, ui: &mut UI) -> Result<(TempDir, PackageIdent)> {
        let workdir = TempDir::new()?;
        let rootfs = workdir.path().join("rootfs");

        ui.status(Status::Creating,
                  format!("build root in {}", workdir.path().display()))?;

        let created_ident = self.prepare_rootfs(ui, &rootfs).await?;

        Ok((workdir, created_ident))
    }

    async fn prepare_rootfs(&self, ui: &mut UI, rootfs: &Path) -> Result<PackageIdent> {
        ui.status(Status::Creating, "root filesystem")?;
        rootfs::create(&rootfs)?;
        self.create_symlink_to_artifact_cache(ui, &rootfs)?;
        self.create_symlink_to_key_cache(ui, &rootfs)?;
        self.install_base_pkgs(ui, &rootfs).await?;
        let ident = self.install_user_pkg(ui, self.ident_or_archive, rootfs)
                        .await?;
        self.remove_symlink_to_key_cache(ui, &rootfs)?;
        self.remove_symlink_to_artifact_cache(ui, &rootfs)?;

        Ok(ident)
    }

    fn create_symlink_to_artifact_cache<P: AsRef<Path>>(&self,
                                                        ui: &mut UI,
                                                        rootfs: P)
                                                        -> Result<()> {
        ui.status(Status::Creating, "artifact cache symlink")?;
        let src = cache_artifact_path(None::<P>);
        let dst = rootfs.as_ref().join(CACHE_ARTIFACT_PATH);
        stdfs::create_dir_all(dst.parent().expect("parent directory exists"))?;
        debug!("Symlinking src: {} to dst: {}",
               src.display(),
               dst.display());

        symlink(src, dst)?;
        Ok(())
    }

    fn create_symlink_to_key_cache<P: AsRef<Path>>(&self, ui: &mut UI, rootfs: P) -> Result<()> {
        ui.status(Status::Creating, "key cache symlink")?;
        let src = &*CACHE_KEY_PATH;
        let dst = rootfs.as_ref().join(CACHE_KEY_PATH_POSTFIX);
        stdfs::create_dir_all(dst.parent().expect("parent directory exists"))?;
        debug!("Symlinking src: {} to dst: {}",
               src.display(),
               dst.display());

        symlink(src, dst)?;
        Ok(())
    }

    async fn install_base_pkgs(&self, ui: &mut UI, rootfs: &Path) -> Result<BasePkgIdents> {
        let bio = self.install_base_pkg(ui, self.bio, rootfs).await?;
        let sup = self.install_base_pkg(ui, self.bio_sup, rootfs).await?;
        let launcher = self.install_base_pkg(ui, self.bio_launcher, rootfs).await?;

        // TODO (CM): at some point this should be considered as
        // something other than a "base" package... replacing busybox
        // isn't really something that's going to need to be done.
        let busybox = if cfg!(target_os = "linux") {
            Some(self.install_stable_pkg(ui, BUSYBOX_IDENT, rootfs).await?)
        } else {
            None
        };

        Ok(BasePkgIdents { bio,
                           sup,
                           launcher,
                           busybox })
    }

    async fn install_base_pkg(&self,
                              ui: &mut UI,
                              ident_or_archive: &str,
                              fs_root_path: &Path)
                              -> Result<PackageIdent> {
        self.install(ui,
                     ident_or_archive,
                     self.base_pkgs_url,
                     &self.base_pkgs_channel,
                     fs_root_path,
                     None)
            .await
    }

    async fn install_stable_pkg(&self,
                                ui: &mut UI,
                                ident_or_archive: &str,
                                fs_root_path: &Path)
                                -> Result<PackageIdent> {
        self.install(ui,
                     ident_or_archive,
                     &self.base_pkgs_url,
                     &ChannelIdent::stable(),
                     fs_root_path,
                     None)
            .await
    }

    async fn install_user_pkg(&self,
                              ui: &mut UI,
                              ident_or_archive: &str,
                              fs_root_path: &Path)
                              -> Result<PackageIdent> {
        self.install(ui,
                     ident_or_archive,
                     self.url,
                     &self.channel,
                     fs_root_path,
                     self.auth)
            .await
    }

    async fn install(&self,
                     ui: &mut UI,
                     ident_or_archive: &str,
                     url: &str,
                     channel: &ChannelIdent,
                     fs_root_path: &Path,
                     token: Option<&str>)
                     -> Result<PackageIdent> {
        let install_source: InstallSource = ident_or_archive.parse()?;
        let package_install =
            common::command::package::install::start(ui,
                                                     url,
                                                     channel,
                                                     &install_source,
                                                     &*PROGRAM_NAME,
                                                     VERSION,
                                                     fs_root_path,
                                                     &cache_artifact_path(Some(&fs_root_path)),
                                                     token,
                                                     // TODO fn: pass through and enable offline
                                                     // install mode
                                                     &InstallMode::default(),
                                                     // TODO (CM): pass through and enable
                                                     // ignore-local mode
                                                     &LocalPackageUsage::default(),
                                                     InstallHookMode::Ignore).await?;
        Ok(package_install.into())
    }

    fn remove_symlink_to_artifact_cache<P: AsRef<Path>>(&self,
                                                        ui: &mut UI,
                                                        rootfs: P)
                                                        -> Result<()> {
        ui.status(Status::Deleting, "artifact cache symlink")?;
        stdfs::remove_dir_all(rootfs.as_ref().join(CACHE_ARTIFACT_PATH))?;
        Ok(())
    }

    fn remove_symlink_to_key_cache<P: AsRef<Path>>(&self, ui: &mut UI, rootfs: P) -> Result<()> {
        ui.status(Status::Deleting, "artifact key symlink")?;
        stdfs::remove_dir_all(rootfs.as_ref().join(CACHE_KEY_PATH_POSTFIX))?;

        Ok(())
    }
}

/// The package identifiers for installed base packages.
#[derive(Debug)]
struct BasePkgIdents {
    /// Installed package identifer for the Biome CLI package.
    pub bio:      PackageIdent,
    /// Installed package identifer for the Supervisor package.
    pub sup:      PackageIdent,
    /// Installed package identifer for the Launcher package.
    pub launcher: PackageIdent,
    /// Installed package identifer for the Busybox package.
    pub busybox:  Option<PackageIdent>,
}
