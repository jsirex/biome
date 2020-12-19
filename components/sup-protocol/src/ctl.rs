//! Specific request, responses, and types used to specifically communicate with the Supervisor's
//! Control Gateway.
//!
//! Note: See `protocols/ctl.proto` for type level documentation for generated types.

use crate::message;
use std::fmt;

include!(concat!(env!("OUT_DIR"), "/sup.ctl.rs"));

impl message::MessageStatic for NetProgress {
    const MESSAGE_ID: &'static str = "NetProgress";
}

impl message::MessageStatic for Handshake {
    const MESSAGE_ID: &'static str = "Handshake";
}

impl message::MessageStatic for ServiceBindList {
    const MESSAGE_ID: &'static str = "ServiceBindList";
}

impl message::MessageStatic for SupDepart {
    const MESSAGE_ID: &'static str = "SupDepart";
}

impl message::MessageStatic for SupRestart {
    const MESSAGE_ID: &'static str = "SupRestart";
}

impl message::MessageStatic for SvcFilePut {
    const MESSAGE_ID: &'static str = "SvcFilePut";
}

impl message::MessageStatic for SvcGetDefaultCfg {
    const MESSAGE_ID: &'static str = "SvcGetDefaultCfg";
}

impl message::MessageStatic for SvcValidateCfg {
    const MESSAGE_ID: &'static str = "SvcValidateCfg";
}

impl message::MessageStatic for SvcSetCfg {
    const MESSAGE_ID: &'static str = "SvcSetCfg";
}

impl message::MessageStatic for SvcLoad {
    const MESSAGE_ID: &'static str = "SvcLoad";
}

impl message::MessageStatic for SvcUpdate {
    const MESSAGE_ID: &'static str = "SvcUpdate";
}

impl message::MessageStatic for SvcUnload {
    const MESSAGE_ID: &'static str = "SvcUnload";
}

impl message::MessageStatic for SvcStart {
    const MESSAGE_ID: &'static str = "SvcStart";
}

impl message::MessageStatic for SvcStop {
    const MESSAGE_ID: &'static str = "SvcStop";
}

impl message::MessageStatic for SvcStatus {
    const MESSAGE_ID: &'static str = "SvcStatus";
}

impl message::MessageStatic for ConsoleLine {
    const MESSAGE_ID: &'static str = "ConsoleLine";
}

impl fmt::Display for ConsoleLine {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result { write!(f, "{}", self.line) }
}

impl std::iter::FromIterator<biome_core::service::ServiceBind> for ServiceBindList {
    fn from_iter<T>(iter: T) -> Self
        where T: IntoIterator<Item = biome_core::service::ServiceBind>
    {
        ServiceBindList { binds: iter.into_iter().map(Into::into).collect(), }
    }
}

impl Into<Vec<biome_core::service::ServiceBind>> for ServiceBindList {
    fn into(self) -> Vec<biome_core::service::ServiceBind> {
        self.binds.into_iter().map(Into::into).collect()
    }
}
