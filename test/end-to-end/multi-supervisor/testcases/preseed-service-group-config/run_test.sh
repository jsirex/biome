#!/bin/bash

set -xeuo pipefail

# Ensures that we can `bio config apply` some configuration to a
# Biome network before any services are running, and have those
# services pick up the configuration the first time they load.

new_port=8888

# Add some non-standard configuration to the network BEFORE we run
# anything in the targeted service group.
#
# Normally, Redis is available at port 6379, but here we're setting it
# to 8888.
echo -e "port = ${new_port}\nprotected-mode = \"no\"" |
bio config apply \
    redis.default \
    "$(date +%s)" \
    --remote-sup=bastion.biome.dev

# Install redis locally so we have access to the redis CLI
bio pkg install core/redis
bio pkg exec core/redis redis-cli --version

# Start up a redis instance in the network and wait for it to come
# up. We expect it to pick up the configuration we injected into the
# network earlier.
bio svc load core/redis --remote-sup=alpha.biome.dev
sleep 10

# We should be able to interact with the service at the new,
# non-standard port without a problem.
bio pkg exec core/redis redis-cli \
    -h "alpha.biome.dev" \
    -p "${new_port}" \
    SET secret_message "Hello World"
