#!/bin/bash

# install mysql
wget http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum localinstall -y mysql57-community-release-el7-11.noarch.rpm
yum install -y mysql-community-server

# copy mysql connector
cp /usr/java/latest/mysql-connector-java.jar /opt/cm/share/cmf/lib/

# config mysql
sed -i /^"\[mysqld\]"/a\\"skip-grant-tables" /etc/my.cnf
mysql -u root
create database hive DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
create database amon DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
create database hue DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
create database monitor DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
create database oozie DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
grant all on *.* to root@"%" Identified by "1234.com";

# clean
rm -f mysql57-community-release-el7-11.noarch.rpm
yum clean all
rm -rf /var/cache/yum/*