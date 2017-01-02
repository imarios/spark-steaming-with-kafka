#!/usr/bin/env bash

for i in $(seq 1 3); do
   vagrant ssh broker$i -c "nohup /vagrant/scripts/zk.sh $i"
done

for i in $(seq 1 3); do
   res=$(vagrant ssh broker$i -c "jps" | grep QuorumPeerMain)
   echo "$i: $res"
done

echo "Zk started"
