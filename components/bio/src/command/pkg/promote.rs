//! Promote a package to a specified channel.
//!
//! # Examples
//!
//! ```bash
//! $ bio pkg promote acme/redis/2.0.7/2112010203120101 stable
//! ```
//! //! This will promote the acme package specified to the stable channel.
//!
//! Notes:
//!    The package should already have been uploaded to Builder.
//!    If the specified channel does not exist, it will be created.

use crate::{api_client::{self,
                         Client},
            common::ui::{Status,
                         UIWriter,
                         UI},
            hcore::{package::{PackageIdent,
                              PackageTarget},
                    ChannelIdent}};
use reqwest::StatusCode;

use crate::{error::{Error,
                    Result},
            PRODUCT,
            VERSION};

/// Promote a package to the specified channel.
///
/// # Failures
///
/// * Fails if it cannot find the specified package in Builder
pub async fn start(ui: &mut UI,
                   bldr_url: &str,
                   (ident, target): (&PackageIdent, PackageTarget),
                   channel: &ChannelIdent,
                   token: &str)
                   -> Result<()> {
    let api_client = Client::new(bldr_url, PRODUCT, VERSION, None)?;

    ui.begin(format!("Promoting {} ({}) to channel '{}'", ident, target, channel))?;

    if channel != &ChannelIdent::stable() && channel != &ChannelIdent::unstable() {
        match api_client.create_channel(&ident.hacky_get_origin(), channel, token)
                        .await
        {
            Ok(_) => (),
            Err(api_client::Error::APIError(StatusCode::CONFLICT, _)) => (),
            Err(e) => {
                println!("Failed to create '{}' channel: {:?}", channel, e);
                return Err(Error::from(e));
            }
        };
    }

    match api_client.promote_package((ident, target), channel, token)
                    .await
    {
        Ok(_) => (),
        Err(e) => {
            println!("Failed to promote '{}': {:?}", ident, e);
            if let api_client::Error::APIError(StatusCode::NOT_FOUND, _) = e {
                println!("You may need to specify a platform target argument");
            }
            return Err(Error::from(e));
        }
    }

    ui.status(Status::Promoted, format!("{} ({})", ident, target))?;

    Ok(())
}
