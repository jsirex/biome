use crate::{command::studio,
            common::ui::UI,
            error::Result};
use biome_core::origin::Origin;
use std::ffi::OsString;

/// origins - origins whose secret signing keys should be made
///           available in the build
#[allow(clippy::too_many_arguments)]
pub async fn start(ui: &mut UI,
                   plan_context: &str,
                   root: Option<&str>,
                   src: Option<&str>,
                   origins: &[Origin],
                   reuse: bool,
                   docker: bool)
                   -> Result<()> {
    let mut args: Vec<OsString> = Vec::new();
    if let Some(root) = root {
        args.push("-r".into());
        args.push(root.into());
    }
    if let Some(src) = src {
        args.push("-s".into());
        args.push(src.into());
    }

    if !origins.is_empty() {
        let signing_key_names = origins.iter()
                                       .map(AsRef::as_ref)
                                       .collect::<Vec<&str>>()
                                       .join(",");
        args.push("-k".into());
        args.push(signing_key_names.into());
    }

    args.push("build".into());
    if studio::native_studio_support() && reuse {
        args.push("-R".into());
    }
    args.push(plan_context.into());
    if studio::native_studio_support() && docker {
        args.push("-D".into());
    }
    studio::enter::start(ui, &args).await
}
