//
// Copyright:: Copyright (c) 2015 Chef Software, Inc.
// License:: Apache License, Version 2.0
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//! This is the default topology. It's most useful for applications that stand alone, or that don't
//! share state between one another.
//!
//! ![Standalone Topology](../../images/standalone.png)
//!
//! * **Init**: Creates the paths needed for the service in `/opt/bldr/srvc`, and copies in the `run` file
//! from the package.
//! * **Configure**: Writes the `default.toml` from the package, followed by any `environment`
//! configuration (specified as toml in a `$BLDR_service` variable, where `service == redis`, or
//! whatever the name of your service is), data discovered from the system, data from the bldr
//! package iteslf, and if configured, from a discovery service.
//! * **Starting**: Starts the service under `runsv`, and starts a thread to process output and
//! handle errors.
//! * **Running**: The state for the 'normal' operating condition.
//! * **Finished**: Does nothing; exists to handle cleanup.

use std::thread;
use error::{BldrResult, BldrError};
use std::process::{Command, Stdio};
use std::io::prelude::*;
use ansi_term::Colour::White;
use pkg::Package;
use state_machine::StateMachine;
use topology::{self, State, Worker};
use config::Config;

/// Sets up the topology and calls run_internal.
///
/// Add's the state transitions to the state machine, sets up the signal handlers, and runs the
/// `topology::run_internal` function.
pub fn run(package: Package, config: &Config) -> BldrResult<()> {
    let mut worker = try!(Worker::new(package, String::from("standalone"), config));
    let mut sm: StateMachine<State, Worker, BldrError> = StateMachine::new(State::Init);
    sm.add_dispatch(State::Init, state_init);
    sm.add_dispatch(State::Configure, state_configure);
    sm.add_dispatch(State::Starting, state_starting);
    sm.add_dispatch(State::Running, state_running);
    topology::run_internal(&mut sm, &mut worker)
}

/// Initialize the service.
pub fn state_init(_worker: &mut Worker) -> Result<(State, u32), BldrError> {
    Ok((State::Configure, 0))
}

/// Configure the service.
pub fn state_configure(_worker: &mut Worker) -> Result<(State, u32), BldrError> {
    Ok((State::Starting, 1))
}

/// Start the service.
///
/// 1. Finds the package
/// 1. Starts runit for the `run` script
/// 1. Spawns the supervisor thread
///
/// # Failures
///
/// * If we cannot find the package
/// * If we cannot start the supervisor
pub fn state_starting(worker: &mut Worker) -> Result<(State, u32), BldrError> {
    println!("   {}: Starting", worker.preamble());
    let runit_pkg = try!(Package::latest("runit", None));
    let mut child = try!(
        Command::new(runit_pkg.join_path("bin/runsv"))
        .arg(&format!("/opt/bldr/srvc/{}", worker.package_name))
        .stdin(Stdio::null())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
    );
    worker.supervisor_id = Some(child.id());
    let pkg = worker.package_name.clone();
    let supervisor_thread = try!(thread::Builder::new().name(String::from("supervisor")).spawn(move|| -> BldrResult<()> {
        {
            let mut c_stdout = match child.stdout {
                Some(ref mut s) => s,
                None => return Err(BldrError::UnpackFailed)
            };

            let mut line = format!("   {}({}): ", pkg, White.bold().paint("O"));
            loop {
                let mut buf = [0u8; 1]; // Our byte buffer
                let len = try!(c_stdout.read(&mut buf));
                match len {
                    0 => { // 0 == EOF, so stop writing and finish progress
                        break;
                    },
                    _ => { // Write the buffer to the BufWriter on the Heap
                        let buf_vec = buf[0 .. len].to_vec();
                        let buf_string = String::from_utf8(buf_vec).unwrap();
                        line.push_str(&buf_string);
                        if line.contains("\n") {
                            print!("{}", line);
                            line = format!("   {}({}): ", pkg, White.bold().paint("O"));
                        }
                    }
                }
            }
        }
        Ok(())
    }));
    worker.supervisor_thread = Some(supervisor_thread);
    Ok((State::Running, 0))
}

pub fn state_running(_worker: &mut Worker) -> Result<(State, u32), BldrError> {
    Ok((State::Running, 0))
}
