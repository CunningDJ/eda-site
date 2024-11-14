#!/usr/bin/env bash

source ./globals.sh

function pullAndStartKafkaDocker {
  # Pulling image and running container
  docker_image_uri="apache/kafka:$KAFKA_VERSION"

  echo "Pulling Kafka Docker image: $docker_image_uri"
  docker pull -q $docker_image_uri

  echo "Creating and starting Kafka Docker container from image ..."
  docker_container_id=$(docker run --name "$KAFKA_DOCKER_CONTAINER_NAME" -dq -p $KAFKA_PORT:$KAFKA_PORT $docker_image_uri)
  echo "Created and running Kafka Docker Instance.  Container Name: $KAFKA_DOCKER_CONTAINER_NAME"

  # Saving container ID to file
  storeKafkaContainerId "$docker_container_id"
  echo "Kafka Docker container running on port $KAFKA_PORT: $docker_container_id"
}

function main {
  if ! $(checkKafkaContainerExists); then
    # No container by that name exists
    # Removing the existing ID file
    rm -f $KAFKA_DOCKER_ID_FILE
    # Pulling and starting fresh
    pullAndStartKafkaDocker
  elif ! $(checkKafkaContainerRunning); then
    # Docker container exists but not running.  Starting instance
    echo "Starting Kafka Docker container. Name: $KAFKA_DOCKER_CONTAINER_NAME"
    startKafkaContainer
  else
    # Docker container is running.  Do nothing
    echo "Kafka Docker container is already running: $KAFKA_DOCKER_CONTAINER_NAME";
  fi
}

main