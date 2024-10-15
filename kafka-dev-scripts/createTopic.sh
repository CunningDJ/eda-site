#!/usr/bin/env bash

source ./globals.sh

if [ "$#" -ne 1 ]; then
    echo "Usage: ./createTopic.sh TOPIC_NAME"
    exit 1
fi

topic_name="$1"

docker_container_id="$(getKafkaContainerId)"

echo "Creating topic: $topic_name"
createKafkaTopic "$topic_name"