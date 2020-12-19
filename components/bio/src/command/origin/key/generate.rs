use crate::{common::ui::{UIWriter,
                         UI},
            error::Result};
use biome_core::{crypto::keys::{Key,
                                  KeyCache},
                   origin::Origin};

pub fn start(ui: &mut UI, origin: &Origin, key_cache: &KeyCache) -> Result<()> {
    ui.begin(format!("Generating origin key for {}", origin))?;
    let (public, _secret) = key_cache.new_signing_pair(origin)?;
    ui.end(format!("Generated origin key pair {}.", public.named_revision()))?;
    Ok(())
}
