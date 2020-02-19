use super::util::CacheKeyPath;
use structopt::StructOpt;

#[derive(StructOpt)]
#[structopt(no_version)]
/// Commands relating to Biome users
pub enum User {
    /// Commands relating to Biome user keys
    Key(Key),
}

#[derive(StructOpt)]
#[structopt(no_version)]
/// Commands relating to Biome users
pub enum Key {
    /// Generates a Biome user key
    Generate {
        /// Name of the user key
        #[structopt(name = "USER")]
        user:           String,
        #[structopt(flatten)]
        cache_key_path: CacheKeyPath,
    },
}
