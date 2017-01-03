#!/usr/bin/env bash

source $(dirname $0)/common.sh

if [ $# -eq 2 ]; then
   yes "Hello World" | pv -qL $2 | $kafka_home/bin/kafka-console-producer.sh --topic $1 --broker-list $all_brokers
else
   echo "Usage: "$(basename $0)" <topic> <rate eg 4,1k>"
fi
