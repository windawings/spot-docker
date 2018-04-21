#!/bin/bash

# yum install
yum makecache && yum -y update && yum -y upgrade
yum -y install hadoop-hdfs-namenode
yum clean all && rm -rf /var/cache/yum/*

# create dir
mkdir -p /hdfs/nm

# init namenode
hdfs namenode -format
