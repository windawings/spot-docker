#!/bin/bash

# install mysql
wget http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum localinstall -y mysql57-community-release-el7-11.noarch.rpm
yum install -y mysql-community-server

# copy mysql connector
cp /usr/java/latest/mysql-connector-java.jar /opt/cm/share/cmf/lib/

# clean
rm -f mysql57-community-release-el7-11.noarch.rpm
yum clean all
rm -rf /var/cache/yum/*