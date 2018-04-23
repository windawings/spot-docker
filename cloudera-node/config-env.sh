#!/bin/bash

# yum install
yum -y update && yum -y upgrade
yum -y install epel-release wget ntp openssh*
yum -y install python-pip

# get cloudera.repo
wget http://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo -O /etc/yum.repos.d/cloudera-cdh5.repo
wget http://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo -O /etc/yum.repos.d/cloudera-mng.repo
sed -i.bak s/^.*"baseurl".*/"baseurl=http:\/\/archive.cloudera.com\/cdh5\/redhat\/7\/x86_64\/cdh\/$CDH_VER\/"/ /etc/yum.repos.d/cloudera-cdh5.repo
sed -i.bak s/^.*"baseurl".*/"baseurl=http:\/\/archive.cloudera.com\/cm5\/redhat\/7\/x86_64\/cm\/$CM_VER\/"/ /etc/yum.repos.d/cloudera-mng.repo

# get jdk
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.rpm -O jdk.rpm
rpm -i jdk.rpm

# install hadoop
yum -y remove wget
yum -y install oracle-j2sdk1.7 cloudera-manager-agent cloudera-manager-daemons hadoop

# install supervisor
pip install --upgrade pip
pip install supervisor

# clean
yum clean all
rm -rf /var/cache/yum/*
rm -f jdk.rpm config-env.sh

# ssh login without authetication
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys

# config ntp
echo -e "\nserver s1a.time.edu.cn prefer" >> /etc/ntp.conf
/usr/sbin/ntpdate s1a.time.edu.cn

# create dir
mkdir -p /etc/supervisor/conf.d/
mkdir -p /hdfs/tmp

# config autostart
chkconfig ntpd on
chkconfig sshd on