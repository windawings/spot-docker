#!/bin/bash

# yum install
yum -y install java-1.8.0-openjdk-devel epel-release wget ntp
yum -y update && yum -y upgrade

# get cloudera.repo
mkdir /cloudera_init
cd /cloudera_init
wget http://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo -O /etc/yum.repos.d/cloudera-cdh5.repo
wget http://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo -O /etc/yum.repos.d/cloudera-mng.repo
sed -i.bak s/^.*"baseurl".*/"baseurl=http:\/\/archive.cloudera.com\/cdh5\/redhat\/7\/x86_64\/cdh\/$CDH_VER\/"/ /etc/yum.repos.d/cloudera-cdh5.repo
sed -i.bak s/^.*"baseurl".*/"baseurl=http:\/\/archive.cloudera.com\/cm5\/redhat\/7\/x86_64\/cm\/$CM_VER\/"/ /etc/yum.repos.d/cloudera-mng.repo

# install hadoop
yum -y remove wget
yum -y install hadoop zookeeper  python-pip 
yum clean all
rm -rf /var/cache/yum/*

# install supervisor
pip install --upgrade pip
pip install supervisor

# create dir
mkdir -p /etc/supervisor/conf.d/
mkdir -p /hdfs/tmp

# ntp
ntpdate us.pool.ntp.org