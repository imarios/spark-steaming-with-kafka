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

Note: lines that start with ">" are shell output. 

We can see that each of the nodes is running a ZooKeeper server and a Kafka broker. 









