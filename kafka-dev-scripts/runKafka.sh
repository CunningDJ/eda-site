#!/usr/bin/env bash

source ./constants.sh

docker_name="apache/kafka:$KAFKA_VERSION"

docker pull $docker_name
docker run -p $KAFKA_PORT:$KAFKA_PORT $docker_name
