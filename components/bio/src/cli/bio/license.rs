use structopt::StructOpt;

#[derive(StructOpt)]
#[structopt(no_version)]
/// Commands relating to Biome license agreements
pub enum License {
    /// Accept the Biome Binary Distribution Agreement without prompting
    Accept,
}
