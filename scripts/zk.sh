#!/usr/bin/env bash

source $(dirname $0)/common.sh

# create myid file. see http://zookeeper.apache.org/doc/r3.1.1/zookeeperAdmin.html#sc_zkMulitServerSetup
if [ $# -gt 0 ]; then
  if [ ! -d /tmp/zookeeper ]; then
    echo creating zookeeper data dir...
    mkdir /tmp/zookeeper
    echo $1 > /tmp/zookeeper/myid
  fi

  zk_tmp=/tmp/zookeeper.properties
  cp -f $kafka_home/config/zookeeper.properties $zk_tmp
  cat >> $zk_tmp <<- EOM
tickTime=2000
initLimit=5
syncLimit=2
server.1=${node_ip[1]}:2888:3888
server.2=${node_ip[2]}:2888:3888
server.3=${node_ip[3]}:2888:3888
EOM

  # echo starting zookeeper
  $kafka_home/bin/zookeeper-server-start.sh $zk_tmp > /tmp/zookeeper.log &
  else
    echo "Usage: "$(basename $0)" <zk.id in [1-255]>"
fi
