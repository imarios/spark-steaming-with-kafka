#!/usr/bin/env bash

spark_version="spark-2.2.0-bin-hadoop2.7"
kafka_version="kafka_2.11-0.11.0.2"

node_ip[1]=10.30.3.41
node_ip[2]=10.30.3.42
node_ip[3]=10.30.3.43
zk_port=2181
kafka_port=9092

zk1="${node_ip[1]}:$zk_port"
zk2="${node_ip[2]}:$zk_port"
zk3="${node_ip[3]}:$zk_port"

b1="${node_ip[1]}:$kafka_port"
b2="${node_ip[2]}:$kafka_port"
b3="${node_ip[3]}:$kafka_port"

all_zk="$zk1,$zk2,$zk3"
all_brokers="$b1,$b2,$b3"

kafka_home="$HOME/$kafka_version"
spark_home="$HOME/$spark_version"
