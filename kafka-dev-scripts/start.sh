#!/usr/bin/env bash

./pullKafka.sh

./runKafka.sh

./createTopic.sh counter-topic