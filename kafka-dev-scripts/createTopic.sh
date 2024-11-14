#!/usr/bin/env bash

source ./globals.sh

function main {
    topic_name="$1"

    echo "Creating topic: $topic_name"
    createKafkaTopic "$topic_name"
}

if [ "$#" -ne 1 ]; then
    echo "Usage: ./createTopic.sh TOPIC_NAME"
    exit 1
fi

main "$1"