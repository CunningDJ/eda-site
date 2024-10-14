#!/usr/bin/env bash

source ./constants.sh

# Check if directory exists
if [ ! -d "$KAFKALIB" ]; then
  echo 'Downloading and unzipping Kafka...'
  mkdir -p "$MAINLIB"
  curl -o "$KAFKATGZ_FILEPATH" "$KAFKA_DOWNLOAD_URL"

  tar -xzf "$KAFKATGZ_FILEPATH" -C "$MAINLIB"
  echo "Kafka is downloaded and unzipped in: $KAFKALIB"
else
  echo "Kafka is already pulled in: $KAFKALIB"
fi