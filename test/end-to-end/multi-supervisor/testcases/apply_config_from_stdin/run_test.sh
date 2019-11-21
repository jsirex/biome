#!/bin/bash

set -xeuo pipefail

bio pkg install core/redis
bio pkg exec core/redis redis-cli --version

bio svc load core/redis --remote-sup=alpha.biome.dev
bio svc load core/redis --remote-sup=beta.biome.dev

# TODO Wait until redis is available
sleep 15

new_port=1234

echo -e "port = ${new_port}\nprotected-mode = \"no\"" |
bio config apply \
    redis.default \
    "$(date +%s)" \
    --remote-sup=bastion.biome.dev

sleep 5

for server in alpha beta; do
    bio pkg exec core/redis redis-cli \
        -h "${server}.biome.dev" \
        -p "${new_port}" \
        SET from_stdin_port ${new_port}
done
for server in alpha beta; do
    bio pkg exec core/redis redis-cli \
        -h "${server}.biome.dev" \
        -p "${new_port}" \
        GET from_stdin_port
done
