#!/bin/bash

# install mysql
yum install -q -y wget
wget -q http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum localinstall -q -y mysql57-community-release-el7-11.noarch.rpm
yum install -q -y mysql-community-server

# copy mysql connector
cp /usr/java/latest/mysql-connector-java.jar /opt/cm/share/cmf/lib/

# config autostart
chkconfig ntpd on
chkconfig mysqld on
chkconfig cloudera-scm-agent off

# clean
yum remove -q -y wget
yum clean all
rm -rf /var/cache/yum/*
rm -rf /etc/yum.repo.d/mysql-community*
rm -f mysql57-community-release-el7-11.noarch.rpm /cloudera-init/run/config-env.sh
