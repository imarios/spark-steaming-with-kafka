#!/usr/bin/env bash

for i in $(seq 1 3); do
   vagrant ssh broker$i -c "nohup /vagrant/scripts/broker.sh $i" > /dev/null
done

for i in $(seq 1 3); do
   res=$(vagrant ssh broker$i -c "jps" | grep -i kafka)
   echo "$i: $res"
done

echo "Kafka cluster on"
