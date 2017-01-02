#!/usr/bin/env bash

source $(dirname $0)/common.sh

$kafka_home/bin/kafka-topics.sh --describe --zookeeper $all_zk
