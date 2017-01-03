#!/usr/bin/env bash

source $(dirname $0)/common.sh

if [ $# -gt 0 ]; then
   export SPARK_SUBMIT_OPTS="$SPARK_SUBMIT_OPTS -Dscala.color"
   $spark_home/bin/spark-shell --packages="org.apache.spark:spark-streaming-kafka-0-10_2.11:2.1.0" -i /vagrant/scripts/streaming.scala \
      --conf spark.kafka.streaming.topics="$1"
else 
  echo "Usage: "$(basename $0)" <topic[,topic]>" 
fi
