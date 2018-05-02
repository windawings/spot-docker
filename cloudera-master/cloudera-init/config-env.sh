#!/bin/bash

# install mysql
yum install -q -y wget
wget -q http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum localinstall -q -y mysql57-community-release-el7-11.noarch.rpm
yum install -q -y mysql-community-server

# copy mysql connector
cp /usr/java/latest/mysql-connector-java.jar /opt/cm/share/cmf/lib/

# config mysql
sed -i /^"\[mysqld\]"/a\\"skip-grant-tables" /etc/my.cnf
/usr/bin/mysqld_pre_systemd
/usr/sbin/mysqld --daemonize --pid-file=/var/run/mysqld/mysqld.pid
mysql -u root < /cloudera-init/run/mysql.sql
sed -i /^"skip-grant-tables/d" /etc/my.cnf

# config autostart
chkconfig ntpd on
chkconfig mysqld on

# clean
yum remove -q -y wget
yum clean all
rm -rf /var/cache/yum/*
rm -rf /etc/yum.repo.d/mysql-community*
rm -f mysql57-community-release-el7-11.noarch.rpm /cloudera-init/run/config-env.sh
