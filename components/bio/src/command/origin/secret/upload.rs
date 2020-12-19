use crate::{api_client::Client,
            command::origin::key::download::download_public_encryption_key,
            common::ui::{Status,
                         UIWriter,
                         UI},
            error::{Error,
                    Result},
            PRODUCT,
            VERSION};
use biome_core::{crypto::keys::KeyCache,
                   origin::Origin};

pub async fn start(ui: &mut UI,
                   bldr_url: &str,
                   token: &str,
                   origin: &Origin,
                   key: &str,
                   secret: &str,
                   key_cache: &KeyCache)
                   -> Result<()> {
    let api_client = Client::new(bldr_url, PRODUCT, VERSION, None).map_err(Error::APIClient)?;

    let encryption_key = match key_cache.latest_origin_public_encryption_key(origin) {
        Ok(key) => key,
        Err(_) => {
            debug!("Didn't find public encryption key in cache path");
            download_public_encryption_key(ui, &api_client, origin, token, key_cache).await?;
            key_cache.latest_origin_public_encryption_key(origin)?
        }
    };

    ui.status(Status::Encrypting, format!("value for key {}.", key))?;
    let anonymous_box = encryption_key.encrypt(secret.as_bytes());
    ui.status(Status::Encrypted, format!("{}=[REDACTED].", key))?;

    ui.status(Status::Uploading, format!("secret for key {}.", key))?;

    api_client.create_origin_secret(origin, token, key, &anonymous_box)
              .await
              .map_err(Error::APIClient)?;

    ui.status(Status::Uploaded, format!("secret for {}.", key))?;

    Ok(())
}
