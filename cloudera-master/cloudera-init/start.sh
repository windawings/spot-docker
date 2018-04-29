#!/bin/bash

# config mysql
sed -i /^"\[mysqld\]"/a\\"character-set-server=utf8" /etc/my.cnf
sed -i /^"\[mysqld\]"/a\\"skip-grant-tables" /etc/my.cnf
systemctl restart mysqld
mysql -u root < /cloudera-init/run/mysql.sql
sed -i /^"skip-grant-tables/d" /etc/my.cnf
systemctl restart mysqld
/opt/cm/share/cmf/schema/scm_prepare_database.sh mysql scm scm temp

# check dir for k8s sa
if [ ! -d "/run/secrets/kubernetes.io/serviceaccount" ]; then
  mkdir -p /run/secrets/kubernetes.io/serviceaccount
fi

if [ ! -d "/var/run/secrets/kubernetes.io/serviceaccount" ]; then
  mkdir -p /var/run/secrets/kubernetes.io/serviceaccount
fi

# start server
systemctl start cloudera-scm-server
chkconfig cloudera-scm-server on
exit 0