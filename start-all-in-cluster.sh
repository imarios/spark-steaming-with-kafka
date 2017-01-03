#!/usr/bin/env bash

# first Zk
$(dirname $0)/start-zk-cluster.sh

# then Kafka
$(dirname $0)/start-kafka-cluster.sh
