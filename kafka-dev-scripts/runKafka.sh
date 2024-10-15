#!/usr/bin/env bash

source ./globals.sh

function pullAndStartKafkaDocker {
  # Docker ID file not found; pulling image and running container
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

docker_container_id="$(getKafkaContainerId)"

if [ -z "$docker_container_id" ]; then
  # No docker ID stored: pulling and starting fresh
  echo "No docker ID stored: pulling and starting fresh"
  pullAndStartKafkaDocker
elif ! $(checkKafkaContainerExists "$docker_container_id"); then
  # Docker ID stored but no container by that name exists
  # Removing the existing ID file
  rm -f $KAFKA_DOCKER_ID_FILE
  # Pulling and starting fresh
  pullAndStartKafkaDocker
elif ! $(checkKafkaContainerRunning "$docker_container_id"); then
  # Docker ID instance exists but not running.  Starting instance
  echo "Starting Kafka Docker container. ID: $docker_container_id"
  docker start $docker_container_id
else
  # Docker ID instance is running.  Do nothing
  echo "Kafka Docker container is already running: $docker_container_id";
fi
