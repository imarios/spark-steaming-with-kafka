#!/usr/bin/env bash

nodes=3

for i in $(seq 1 $nodes); do
   echo "Starting zk on $i"
   vagrant ssh broker$i -c "nohup /vagrant/scripts/zk.sh $i" >> /dev/null 2>&1
done

for i in $(seq 1 $nodes); do
   res=$(vagrant ssh broker$i -c "jps" | grep QuorumPeerMain)
   if [ "x$res" = "x" ]; then
      echo "zk not running on $i"
   else
      echo "zk running on $i"
   fi
done

echo "Zk started"
