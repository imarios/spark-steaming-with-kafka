#!/usr/bin/env bash

source $(dirname $0)/common.sh

$kafka_home/bin/zookeeper-server-stop.sh
$kafka_home/bin/kafka-server-stop.sh
