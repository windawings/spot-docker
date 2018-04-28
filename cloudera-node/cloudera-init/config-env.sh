#!/bin/bash

# yum install
yum -q -y update && yum -q -y upgrade
yum -q -y install epel-release wget ntp openssh*
yum -q -y install python-pip python-devel rpcbind crontabs which psmisc MySQL-python at bc bind-libs bind-utils cups-client cups-libs cyrus-sasl-gssapi cyrus-sasl-plain ed fuse fuse-libs httpd httpd-tools keyutils-libs-devel krb5-devel libcom_err-devel libselinux-devel libsepol-devel libverto-devel mailcap noarch mailx mod_ssl openssl-devel pcre-devel postgresql-libs python-psycopg2 redhat-lsb-core redhat-lsb-submod-security x86_64 spax time zlib-devel

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

# config centos
chmod +x /etc/rc.d/rc.local
echo "echo 0 > /proc/sys/vm/swappiness" >> /etc/rc.d/rc.local
echo "echo never > /sys/kernel/mm/transparent_hugepage/defrag" >> /etc/rc.d/rc.local
echo 0 > /proc/sys/vm/swappiness
echo never > /sys/kernel/mm/transparent_hugepage/defrag

# clean
yum clean all
yum -q -y remove wget
rm -rf /var/cache/yum/*
rm -f jdk.rpm cm.tar.gz /cloudera-init/run/config-env.sh

# ssh login without authetication
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys

# config ntp
echo "server s1a.time.edu.cn prefer" >> /etc/ntp.conf

# config user group
useradd --system --home=/opt/cm/run/cloudera-scm-server  --shell=/bin/false --comment "Cloudera SCM User" cloudera-scm

# create dir
mkdir -p /hdfs/tmp/
mkdir -p /hdfs/tmp/
mkdir -p /hdfs/nm/
mkdir -p /hdfs/data/
mkdir -p /cloudera-init/log/
mkdir -p /var/lib/cloudera-scm-server/
mkdir /opt/cm/run/cloudera-scm-agent/
mkdir -p /opt/cm/lib64/cmf/agent/build/env/etc/
chown cloudera-scm:cloudera-scm /var/lib/cloudera-scm-server/

# config autostart
chkconfig sshd on
chkconfig rpcbind on
chkconfig supervisord on