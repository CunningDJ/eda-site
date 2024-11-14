#!/usr/bin/env bash

source ./globals.sh

if $(checkKafkaContainerExists); then
  designation="Kafka docker container $KAFKA_DOCKER_CONTAINER_NAME"
  if $(checkKafkaContainerRunning); then
    echo "Stopping $designation ..."
    stopKafkaContainer
  else
    echo "$designation is already stopped."
  fi
  exit 0
else
  echo "$designation doesn't exist.  Exiting."
  exit 0
fi