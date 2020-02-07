use clap;
use env_logger;
use biome_common::{ui::{UIWriter,
                          UI},
                     PROGRAM_NAME};
use biome_pkg_export_kubernetes as export_k8s;
use log::debug;
use tokio;

#[tokio::main]
async fn main() {
    env_logger::init();
    let mut ui = UI::default_with_env();
    let m = cli().get_matches();
    debug!("clap cli args: {:?}", m);

    if let Err(e) = export_k8s::export_for_cli_matches(&mut ui, &m).await {
        let _ = ui.fatal(e);
        std::process::exit(1)
    }
}

fn cli<'a, 'b>() -> clap::App<'a, 'b> {
    let name: &str = &*PROGRAM_NAME;
    let about = "Creates a Docker image and Kubernetes manifest for a Biome package. Biome \
                 operator must be deployed within the Kubernetes cluster before the generated \
                 manifest can be applied to this cluster.";

    export_k8s::cli::Cli::new(name, about).add_all_args().app
}
