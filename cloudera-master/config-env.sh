#!/bin/bash

# install mysql
yum install -q -y wget
wget -q http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum localinstall -qy mysql57-community-release-el7-11.noarch.rpm
yum install -q -y mysql-community-server

# copy mysql connector
cp /usr/java/latest/mysql-connector-java.jar /opt/cm/share/cmf/lib/

# config mysql
sed -i /^"\[mysqld\]"/a\\"skip-grant-tables" /etc/my.cnf
#systemctl start mysqld
mysqld --daemonize --p -C utf8
mysql -u root
create database scm DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
create database hive DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
create database amon DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
create database hue DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
create database monitor DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
create database oozie DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
grant all on *.* to 'scm'@'localhost' identified by 'temp' with grant option;
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('cloudera');
exit;
/opt/cm/cm/share/cmf/schema/scm_prepare_database.sh  mysql cm -h localhost -u scm -p temp --scm-host localhost scm scm scm
sed -i /^"skip-grant-tables/d" /etc/my.cnf
#systemctl reload mysqld
#systemctl restart mysqld

# clean
yum remove -q -y wget
yum clean all
rm -rf /var/cache/yum/*
rm -f mysql57-community-release-el7-11.noarch.rpm