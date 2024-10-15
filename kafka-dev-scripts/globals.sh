#!/usr/bin/env bash

# Kafka Config
export KAFKA_VERSION=3.8.0
export KAFKA_PORT=9092

# Main Directories
export MAINDIR="$(dirname "$0")"
export MAINLIB="$MAINDIR/lib"

# Kafka Directories
export KAFKA_IMAGENAME="kafka_2.13-$KAFKA_VERSION"
export KAFKATGZ_FILEPATH="$MAINLIB/$KAFKA_IMAGENAME.tgz"
export KAFKALIB="$MAINLIB/$KAFKA_IMAGENAME"
export KAFKABIN="$KAFKALIB/bin"

# Kafka Download URL
export KAFKA_DOWNLOAD_URL="https://dlcdn.apache.org/kafka/$KAFKA_VERSION/$KAFKA_IMAGENAME.tgz"

# Kafka Docker
export KAFKA_DOCKER_ID_FILE="$MAINDIR/.kafka_docker_id"
export KAFKA_DOCKER_CONTAINER_NAME="eda-app-kafka"

function getKafkaContainerId {
  if [ -e "$KAFKA_DOCKER_ID_FILE" ]; then
    cat $KAFKA_DOCKER_ID_FILE
  fi
}

function checkKafkaContainerExists {
  local docker_container_id="$1"
  local container_search_result="$(docker ps -aqf "id=$docker_container_id")"
  if [ -z "$container_search_result" ]; then
    false
  else
    true
  fi
}

function checkKafkaContainerRunning {
  local docker_container_id="$1"
  if [ "$(docker container inspect -f '{{.State.Running}}' $docker_container_id)" ]; then
    true
  else
    false
  fi
}

function storeKafkaContainerId {
  local docker_container_id="$1"
  echo $docker_container_id > $KAFKA_DOCKER_ID_FILE
}

# Docker: Execute
function dockerx {
  local docker_container_id="$1"
  local command="$2"
  docker exec -i --workdir /opt/kafka/bin/ $docker_container_id $command
}

function createKafkaTopic {
  local topic_name="$1"
  dockerx "$docker_container_id" "./kafka-topics.sh --if-not-exists --bootstrap-server localhost:$KAFKA_PORT --create --topic $topic_name"
}

function listKafkaTopics {
  dockerx "$docker_container_id" "./kafka-topics.sh --bootstrap-server localhost:$KAFKA_PORT --list $docker_container_id"
}