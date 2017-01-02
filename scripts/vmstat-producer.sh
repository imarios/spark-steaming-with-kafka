#!/usr/bin/env bash

source $(dirname $0)/common.sh

if [ $# -gt 0 ]; then
   yes | $kafka_home/bin/kafka-console-producer.sh --topic $1 --broker-list $all_brokers
else
   echo "Usage: "$(basename $0)" <topic>"
fi
