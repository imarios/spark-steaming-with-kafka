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

#### Teardown 

To stop both Kafka and ZooKeeper

```bash
./stop-all-in-cluster.sh
```

To suspend the VirtualBox VMs (so you can resume later)

```bash
vagrant suspend
```

To resume

```bash
vagrant resume
#or
vagrant up
```

To delete the VMs and all their files

```bash
vagrant destroy
```

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
> a
> c
> b
# ctrl-C to exit
Processed a total of 3 messages
```

Note that events for the entire topic may come out-of-order. 
Kafka preserves order only within a single partition.

Check the offsets of each partition ([show_offsets.sh](scripts/show_offsets.sh))

```bash
/vagrant/scripts/show_offsets.sh t1
> t1:2:1
> t1:1:1
> t1:0:1
```

Each partition has one event. Kafka was able to evenly distribute the three events 
over the three partitions of the "t1" topic.


Spark streaming consumer
------------

Connect to the Spark VM

```bash
vagrant ssh spark1
```

Start Spark shell with the proper kafka dependecies

```bash
/vagrant/scripts/run_spark_streaming.sh t1
```

When the shell stops loading, implement the most basic consumer (count events in each 10 second interval)

```
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 2.1.0
      /_/

Using Scala version 2.11.8 (OpenJDK 64-Bit Server VM, Java 1.8.0_111)
Type in expressions to have them evaluated.
Type :help for more information.

scala> myStream.count.print

scala> ssc.start
```

From a seperate terminal connect to any of the three broker VMs.

```bash
vagrant ssh broker2
```

Run the [auto_producer.sh](scripts/auto_producer.sh) with a rate of 4k characters per second (each event has 2 charactes which produces a 2k events per second stream).

```bash
/vagrant/scripts/auto_producer.sh t1 4k
```

Going back to your Spark streaming shell you should see something similar to this

```bash
-------------------------------------------
Time: 1483680230000 ms
-------------------------------------------
21060

-------------------------------------------
Time: 1483680240000 ms
-------------------------------------------
19656

-------------------------------------------
Time: 1483680250000 ms
-------------------------------------------
21060
...
```

You can enjoy the spark sreaming UI at http://localhost:4041/streaming/. 
Feel free to kill the Spark shell and the producer when you get board of this :). 


Next steps
------------

Your testbed is now ready for you to experiment. Here are some suggestions:

* Try more complex Spark streaming statements. Search in the [docs](http://spark.apache.org/docs/latest/streaming-programming-guide.html) for inspiration. 
* Try starting `auto_producer.sh` from all three brokers for the same topic. Raise the rates up and see how Spark handles the increased rate. 
* While at least one producer is running, try shutting down one of the other two broker VMs. Observe how Spark Streaming and how Kafka handle the change.










