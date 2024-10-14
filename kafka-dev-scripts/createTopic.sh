#!/usr/bin/env bash

source ./constants.sh

if [ "$#" -ne 1 ]; then
    echo "Usage: ./createTopic.sh TOPIC_NAME"
    exit 1
fi

topic_name="$1"

$KAFKABIN/kafka-topics.sh --create --topic "$topic_name" --bootstrap-server localhost:$KAFKA_PORT