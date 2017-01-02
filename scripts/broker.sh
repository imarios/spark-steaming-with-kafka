#!/usr/bin/env bash

source $(dirname $0)/common.sh

export KAFKA_HEAP_OPTS="-Xmx512m -Xms512m"

if [ $# -gt 0 ]; then
   $kafka_home/bin/kafka-server-start.sh -daemon $HOME/$kafka_version/config/server.properties \
      --override broker.id=$1 --override zookeeper.connect=$all_zk --override listeners=PLAINTEXT://"${node_ip[$1]}:9092"
else
    echo "Usage: "$(basename $0)" <broker.id>"
fi
