#!/usr/bin/env bash

source $(dirname $0)/common.sh

if [ $# -gt 0 ]; then
   $kafka_home/bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list $all_brokers --topic $1
else
   echo "Usage: "$(basename $0)" <topic>"
fi
