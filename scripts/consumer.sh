#!/usr/bin/env bash

source $(dirname $0)/common.sh

if [ $# -gt 0 ]; then
   $kafka_home/bin/kafka-console-consumer.sh --from-beginning --topic $1 --bootstrap-server $all_brokers
else
    echo "Usage: "$(basename $0)" <topic>"
fi
