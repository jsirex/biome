use biome_core as bio_core;
use std::{error,
          fmt,
          io,
          result};

pub type Result<T> = result::Result<T, Error>;

#[derive(Debug)]
pub enum Error {
    BiomeCore(bio_core::Error),
    ReqwestError(reqwest::Error),
    IO(io::Error),
    Json(serde_json::Error),
    UrlParseError(url::ParseError),
}

impl fmt::Display for Error {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let msg = match *self {
            Error::BiomeCore(ref e) => format!("{}", e),
            Error::ReqwestError(ref err) => format!("{}", err),
            Error::IO(ref e) => format!("{}", e),
            Error::Json(ref e) => format!("{}", e),
            Error::UrlParseError(ref e) => format!("{}", e),
        };
        write!(f, "{}", msg)
    }
}

impl error::Error for Error {}

impl From<bio_core::Error> for Error {
    fn from(err: bio_core::Error) -> Error { Error::BiomeCore(err) }
}

impl From<reqwest::Error> for Error {
    fn from(err: reqwest::Error) -> Error { Error::ReqwestError(err) }
}

impl From<io::Error> for Error {
    fn from(err: io::Error) -> Error { Error::IO(err) }
}

impl From<url::ParseError> for Error {
    fn from(err: url::ParseError) -> Self { Error::UrlParseError(err) }
}
