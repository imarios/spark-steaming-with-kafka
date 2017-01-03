#!/usr/bin/env bash

nodes=3

for i in $(seq 1 $nodes); do
   vagrant ssh broker$i -c "nohup /vagrant/scripts/broker.sh $i" > /dev/null
done

for i in $(seq 1 $nodes); do
   res=$(vagrant ssh broker$i -c "jps" | grep -i kafka)
   if [ "x$res" = "x" ]; then
      echo "Kafka not up on $i"
   else
      echo "Kafka is running on $i"
   fi
done

echo "Kafka cluster on"
