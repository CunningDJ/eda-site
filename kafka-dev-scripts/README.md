# EDA App - Kafka Setup Scripts
**For quickstart instructions, look at the [top level README](/README.md#getting-started)**

## Setup
1. Run `npm run start:kafka` to set up and run the Kafka server

You're done!  This script will pull down [Kafka utility scripts](https://www.apache.org/dyn/closer.cgi?path=/kafka/3.8.0/kafka_2.13-3.8.0.tgz) to use in these bash wrapper scripts (and for your own use if you want to talk to Kafka directly), and download the [apache/kafka](https://hub.docker.com/r/apache/kafka) Docker image and start it.  If you run this again, it won't re-download the kafka scripts unless their directory was deleted, it will just run the rest.

Currently, this runs Kafka **3.8.0**. See the [constants.sh](constants.sh) script for the configuration variables.

## Stop Kafka
Run `npm run stop:kafka` stop the Kafka server.