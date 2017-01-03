#!/usr/bin/env bash

# Needs to refer to /vagrant since file is moved on provisioning step
source "/vagrant/scripts/common.sh"

echo "Installing Java 8"
apt-get -y install openjdk-8-jdk-headless > /dev/null 2>&1
apt-get -y install pv 

spark_tar="$spark_version.tgz"
echo "Installing $spark_version"
wget http://d3kbcqa49mib13.cloudfront.net/$spark_tar > /dev/null 2>&1
tar -xvf $spark_tar > /dev/null 2>&1

kafka_tar="$kafka_version.tgz"
echo "Installing $kafka_version"
wget http://apache.claz.org/kafka/0.10.1.0/$kafka_tar > /dev/null 2>&1
tar -xvf $kafka_tar > /dev/null 2>&1

# disable iptables
ufw disable

chown vagrant:vagrant -R /home/vagrant/

chmod u+x /vagrant/scripts/*.sh
