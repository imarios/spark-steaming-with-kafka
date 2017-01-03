# Spark Steaming with Kafka

**Goal:** Uses [Vagrant](https://www.vagrantup.com) to create a 4 Virtual Machine (VM) cluster (3 running Kafka 1 running Spark) to expriment with Spark Streaming and Kafka.

- Spark Streaming v2.1.0
- Kafka v0.10.1

Requirements
------------

- [Vagrant](https://www.vagrantup.com) (tested with 1.9.1)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (tested with 5.1.12 r112440)


Getting started
------------

First install VirtualBox and Vagrant. 

Clone this repository

```bash
git clone https://github.com/imarios/spark-steaming-with-kafka.git
```

Create and provision the VMs

```bash
cd spark-steaming-with-kafka
vagrant up
```
**Note:** the above can take several minutes, especially the first time it runs (needs to download the Ubuntu Vagrant Box and install the required packages on each VM). This will take long only the first time, starting and stoping the VMs hereafter will be significantly faster. 


When all VMs are ready

```bash
./start-all-in-cluster.sh
```

This will start a thee node ZooKeeper quorum and a three broker Kafka on the same three nodes. 

```bash
vagrant ssh broker1 -c "jps"
> 17235 Jps
> 15605 QuorumPeerMain
> 16134 Kafka
```

*Note: lines that start with ">" are shell output.*

We can see that each of the nodes is running a ZooKeeper server and a Kafka broker. 

Kafka basics
------------

Create a topic called "t1" with replication factor 2 and 3 number of
partitions. You can use the custom scripts provided by Kafka or use
the script ([create_topic.sh](scripts/create_topic.sh)) provided here.

```bash
vagrant ssh spark1
/vagrant/scripts/create_topic.sh t1 2 3
```

Verify that the topic is created

```bash
# Assumes you are in any of the 4VMs
/vagrant/scripts/list_topics.sh
> __consumer_offsets
> t1
```

Add events to the topic ([producer.sh](scripts/producer.sh))

```bash
/vagrant/scripts/producer.sh t1
a
b
c
# ctrl-C to exit
```

Read the events back ([consumer.sh](scripts/consumer.sh))

```bash
/vagrant/scripts/consumer.sh t1
a
c
b
# ctrl-C to exit
Processed a total of 3 messages
```

Note that events for the entire topic may come out-of-order. 
Kafka preserves order only within a single partition.










