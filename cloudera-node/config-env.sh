#!/bin/bash

# yum install
yum -y update && yum -y upgrade
yum -y install epel-release wget ntp openssh*
yum -y install python-pip rpcbind

# get cloudera repo
wget http://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo -O /etc/yum.repos.d/cloudera-cdh5.repo
wget http://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo -O /etc/yum.repos.d/cloudera-mng.repo
sed -i.bak s/^.*"baseurl".*/"baseurl=http:\/\/archive.cloudera.com\/cdh5\/redhat\/7\/x86_64\/cdh\/$CDH_VER\/"/ /etc/yum.repos.d/cloudera-cdh5.repo
sed -i.bak s/^.*"baseurl".*/"baseurl=http:\/\/archive.cloudera.com\/cm5\/redhat\/7\/x86_64\/cm\/$CM_VER\/"/ /etc/yum.repos.d/cloudera-mng.repo

# install jdk
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.rpm -O jdk.rpm
http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.46/mysql-connector-java-5.1.46.jar -O mysql-connector-java.jar
rpm -i jdk.rpm
mv mysql-connector-java.jar /usr/java/latest/

# install cloudera
wget http://archive.cloudera.com/cm5/cm/5/cloudera-manager-centos7-cm5.14.2_x86_64.tar.gz -O cm.tar.gz
tar zxvf cm.tar.gz -C /opt/
mv /opt/cm-5.10.0 /opt/cm

# install supervisor
pip install --upgrade pip
pip install supervisor

# config centos
chmod +x /etc/rc.d/rc.local
echo "echo 0 > /proc/sys/vm/swappiness" >>/etc/rc.d/rc.local
echo "echo never > /sys/kernel/mm/transparent_hugepage/defrag" >>/etc/rc.d/rc.local
echo 0 > /proc/sys/vm/swappiness
echo never > /sys/kernel/mm/transparent_hugepage/defrag

# clean
yum clean all
yum -y remove wget
rm -rf /var/cache/yum/*
rm -f jdk.rpm config-env.sh cm.tar.gz

# ssh login without authetication
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys

# config ntp
echo "server s1a.time.edu.cn prefer" >> /etc/ntp.conf

# config user group
useradd --system --home=/opt/cm/run/cloudera-scm-server  --shell=/bin/false --comment "Cloudera SCM User" cloudera-scm

# create dir
mkdir /opt/cm/run/cloudera-scm-agent
mkdir -p /etc/supervisor/conf.d/
mkdir -p /hdfs/tmp
mkdir -p /hdfs/nm
mkdir -p /hdfs/data

# config autostart
chkconfig ntpd on
chkconfig sshd on
chkconfig rpcbind on