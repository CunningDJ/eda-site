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


