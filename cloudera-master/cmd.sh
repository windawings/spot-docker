#!/bin/bash

# config mysql
sed -i /^"\[mysqld\]"/a\\"character-set-server=utf8" /etc/my.cnf
sed -i /^"\[mysqld\]"/a\\"skip-grant-tables" /etc/my.cnf
systemctl restart mysqld
mysql -u root < mysql.sql
sed -i /^"skip-grant-tables/d" /etc/my.cnf
systemctl restart mysqld
/opt/cm/share/cmf/schema/scm_prepare_database.sh mysql scm scm temp

# clean
rm -f /etc/supervisor/cmd.sh
rm -f mysql.sql