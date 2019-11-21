#!/bin/bash

set -xeuo pipefail

bio pkg install core/redis
bio pkg exec core/redis redis-cli --version

bio svc load core/redis --remote-sup=alpha.biome.dev
bio svc load core/redis --remote-sup=beta.biome.dev

# TODO Wait until redis is available
sleep 15

echo "Hello from Biome!" > message.txt
bio file upload \
    redis.default \
    "$(date +%s)" \
    message.txt \
    --remote-sup=bastion.biome.dev

# TODO give the file time to get out
sleep 5

for service in alpha beta; do
    # TODO (CM): abstract this pattern a bit better
    docker exec "${COMPOSE_PROJECT_NAME}_${service}_1" cat /hab/svc/redis/files/message.txt
done
