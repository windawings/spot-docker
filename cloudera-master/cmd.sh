#!/bin/bash

# config mysql
sed -i /^"\[mysqld\]"/a\\"skip-grant-tables" /etc/my.cnf
systemctl start mysqld
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
systemctl reload mysqld
systemctl restart mysqld

# clean
rm -f cmd.sh