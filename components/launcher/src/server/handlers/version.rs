use super::{HandleResult,
            Handler};
use crate::{protocol,
            server::ServiceTable,
            VERSION};

pub struct VersionHandler;

impl Handler for VersionHandler {
    type Message = protocol::Version;
    type Reply = protocol::VersionNumber;

    fn handle(_: Self::Message, _: &mut ServiceTable) -> HandleResult<Self::Reply> {
        // VERSION will be none if this is a cargo built binary as opposed to
        // being built by our bio plan. So in that case we will fallback to u32::MAX.
        let max = u32::MAX.to_string();
        let version = VERSION.unwrap_or(&max);
        match version.parse::<u32>() {
            Ok(v) => {
                let reply = protocol::VersionNumber { version: v };
                Ok(reply)
            }
            Err(err) => {
                let err_msg = format!("Unable to parse version {}: {}", version, err.to_string());
                let mut reply = protocol::NetErr::default();
                reply.code = protocol::ErrCode::InvalidVersionNumber;
                reply.msg = err_msg;
                Err(reply)
            }
        }
    }
}
