#!/usr/bin/env bash

source $(dirname $0)/common.sh

$kafka_home/bin/kafka-topics.sh --list --zookeeper $all_zk
