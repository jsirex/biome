use configopt::ConfigOpt;
use structopt::StructOpt;

#[derive(ConfigOpt, StructOpt)]
#[structopt(no_version)]
/// Commands relating to Biome license agreements
pub enum License {
    /// Accept the Biome Binary Distribution Agreement without prompting
    Accept,
}
