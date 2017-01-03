#!/usr/bin/env bash

source $(dirname $0)/common.sh

if [ $# -gt 0 ]; then
   $kafka_home/bin/kafka-console-producer.sh \
      --topic $1 \
      --broker-list $all_brokers \
      --property parse.key=true \
      --property key.separator=,
else
   echo "Usage: "$(basename $0)" <topic>"
fi
