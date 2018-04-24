#!/bin/bash

# install mysql
yum install -q -y wget
wget -q http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum localinstall -q -y mysql57-community-release-el7-11.noarch.rpm
yum install -q -y mysql-community-server

# copy mysql connector
cp /usr/java/latest/mysql-connector-java.jar /opt/cm/share/cmf/lib/

# clean
yum remove -q -y wget
yum clean all
rm -rf /var/cache/yum/*
rm -f mysql57-community-release-el7-11.noarch.rpm