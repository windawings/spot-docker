#!/bin/bash

# yum install
yum -q -y update && yum -q -y upgrade
yum -q -y install epel-release wget ntp openssh*
yum -q -y install python-pip python-devel rpcbind

# get cloudera repo
wget -q http://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo -O /etc/yum.repos.d/cloudera-cdh5.repo
wget -q http://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo -O /etc/yum.repos.d/cloudera-mng.repo
sed -i.bak s/^.*"baseurl".*/"baseurl=http:\/\/archive.cloudera.com\/cdh5\/redhat\/7\/x86_64\/cdh\/$CDH_VER\/"/ /etc/yum.repos.d/cloudera-cdh5.repo
sed -i.bak s/^.*"baseurl".*/"baseurl=http:\/\/archive.cloudera.com\/cm5\/redhat\/7\/x86_64\/cm\/$CM_VER\/"/ /etc/yum.repos.d/cloudera-mng.repo

# install jdk
wget -q --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.rpm -O jdk.rpm
rpm -i jdk.rpm
wget -q http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.46/mysql-connector-java-5.1.46.jar -O mysql-connector-java.jar
mv mysql-connector-java.jar /usr/java/latest/

# install cloudera
wget -q http://archive.cloudera.com/cm5/cm/5/cloudera-manager-centos7-cm5.14.2_x86_64.tar.gz -O cm.tar.gz
tar zxf cm.tar.gz -C /opt/
mv /opt/cm-5.14.2 /opt/cm
sed -i s/^.*"cloudera_mysql_connector_jar".*/"cloudera_mysql_connector_jar=\/usr\/java\/latest\/mysql-connector-java.jar"/ /opt/cm/etc/cloudera-scm-agent/config.ini

# install supervisor
pip install -q --upgrade pip
pip install -q supervisor

# config centos
chmod +x /etc/rc.d/rc.local
echo "echo 0 > /proc/sys/vm/swappiness" >>/etc/rc.d/rc.local
echo "echo never > /sys/kernel/mm/transparent_hugepage/defrag" >>/etc/rc.d/rc.local
echo 0 > /proc/sys/vm/swappiness
echo never > /sys/kernel/mm/transparent_hugepage/defrag

# clean
yum clean all
yum -q -y remove wget
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
mkdir -p /var/log/supervisor
mkdir /var/lib/cloudera-scm-server
chown cloudera-scm:cloudera-scm /var/lib/cloudera-scm-server

# config autostart
chkconfig ntpd on
chkconfig sshd on
chkconfig rpcbind on
chkconfig supervisord on