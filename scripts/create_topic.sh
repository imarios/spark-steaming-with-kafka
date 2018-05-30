#!/usr/bin/env bash

source $(dirname $0)/common.sh

if [ $# -eq 3 ]; then
   $kafka_home/bin/kafka-topics.sh --zookeeper $all_zk --replication-factor $2 --partitions $3 --topic $1 --create
else
    echo "Usage: "$(basename $0)" <topic> <replication> <partitions>"
fi
