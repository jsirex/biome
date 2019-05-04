// Copyright (c) 2016 Chef Software Inc. and/or applicable contributors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//! Biome helps you build, manage, and run applications - on bare metal, in the cloud, and in
//! containers. You can [read more about it on the website](https://www.biome.sh/).
//!
//! Biome contains two main components:
//!
//! * `bio-plan-build`, takes a plan ('plan.sh'), a description of how to build a piece of software,
//! written in [bash](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html), which produces an atomic
//! package.
//! * `bio-sup`, a run-time executable that knows how to download, install, serve, and
//! manage services defined in packages.
//!
//! # bio-plan-build
//!
//! The documentation for bio-plan-build is generated automatically from the script itself, [and
//! can be found here](bio-plan-build/bio-plan-build.html). You can find it in the source tree at
//! `components/plan-build`.
//!
//! # The Supervisor
//!
//! The Supervisor is primarily utilized through the `bio-sup` command; it can also be used from
//! within Rust as a library. This documentation covers both uses; it explains how things are used
//! from the command line in close proximity to the documentation of the library itself. A few
//! useful starting points:
//!
//! * [The Biome Command Line Reference](command)
//! * [The Biome Supervisor Sidecar; http interface to promises](sidecar)

#[cfg(target_os = "linux")]
extern crate caps;
extern crate clap;
extern crate cpu_time;
#[cfg(windows)]
extern crate ctrlc;
#[macro_use]
extern crate lazy_static;
#[macro_use]
extern crate log;
extern crate notify;
extern crate num_cpus;
#[cfg(unix)]
extern crate palaver;
#[macro_use]
extern crate prometheus;
extern crate prost;
extern crate protobuf;
extern crate rand;
extern crate regex;
extern crate rustls;
extern crate serde;
#[macro_use]
extern crate serde_derive;
#[allow(unused_imports)]
#[macro_use]
extern crate serde_json;
extern crate time as time_crate;

#[cfg(test)]
extern crate json;

#[macro_export]
/// Creates a new SupError, embedding the current file name, line number, column, and module path.
macro_rules! sup_error {
    ($p:expr) => {{
        use $crate::error::SupError;
        SupError::new($p, LOGKEY, file!(), line!(), column!())
    }};
}

#[cfg(test)]
#[macro_use]
pub mod cli_test_helpers;
pub mod census;
pub mod cli;
pub mod command;
pub mod config;
pub mod ctl_gateway;
pub mod error;
mod event;
pub mod http_gateway;
pub mod manager;
mod sys;
#[cfg(test)]
pub mod test_helpers;
pub mod util;

use std::env;

pub const PRODUCT: &str = "bio-sup";
pub const VERSION: &str = include_str!(concat!(env!("OUT_DIR"), "/VERSION"));
