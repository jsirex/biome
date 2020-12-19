extern crate biome_core as core;
use biome_launcher_protocol as protocol;
#[macro_use]
extern crate log;
#[cfg(windows)]
extern crate winapi;

pub mod error;
pub mod server;
pub mod service;
mod sys;

pub const SUP_CMD: &str = "bio-sup";
pub const SUP_PACKAGE_IDENT: &str = "biome/bio-sup";
pub const VERSION: Option<&str> = option_env!("PLAN_VERSION");
