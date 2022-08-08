#!/bin/bash

export ELASTIC_VERSION=7.9.1
export ELASTICSEARCH_USERNAME=elastic
export ELASTICSEARCH_PASSWORD=# your password
export ELASTICSEARCH_HOST=#your node name
export INITIAL_MASTER_NODES=#your node name

docker network create --driver overlay --attachable elastic
docker stack deploy --compose-file docker-compose.yml elastic
