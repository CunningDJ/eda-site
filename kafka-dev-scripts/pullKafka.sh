#!/usr/bin/env bash

source ./globals.sh

# Check if Kafka scripts directory exists
if [ ! -d "$KAFKALIB" ]; then
  echo 'Downloading and unzipping Kafka utility scripts ...'
  mkdir -p "$MAINLIB"
  curl -o "$KAFKATGZ_FILEPATH" "$KAFKA_DOWNLOAD_URL"

  tar -xzf "$KAFKATGZ_FILEPATH" -C "$MAINLIB"
  echo "Kafka scripts are downloaded and unzipped in: $KAFKALIB"
else
  echo "Kafka scripts are already pulled: $KAFKALIB"
fi