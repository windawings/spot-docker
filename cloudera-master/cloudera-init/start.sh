#!/bin/bash

# check mysqld
echo "[+] $(date) check mysql"
while [ $(ps -ef | grep mysqld | egrep -v grep | wc -l) -eq 0 ]; do
  echo "[-] $(date) mysqld is not running"
  sleep 2s
done

# wait for mysql ready
echo "[+] $(date) wait 15s for mysql ready"
sleep 15s

# config mysql
if [ $(grep -c "character-set-server=utf8" /etc/my.cnf) -eq 0 ]; then
  echo "[+] $(date) config mysql utf8 charset"
  sed -i /^"\[mysqld\]"/a\\"character-set-server=utf8" /etc/my.cnf
  systemctl restart mysqld
fi

if [ ! -d /var/lib/mysql/scm ]; then
  echo "[+] $(date) config cloudera mysql"
  sed -i /^"\[mysqld\]"/a\\"skip-grant-tables" /etc/my.cnf
  systemctl restart mysqld
  mysql -u root < /cloudera-init/run/mysql.sql
  sed -i /^"skip-grant-tables/d" /etc/my.cnf
  systemctl restart mysqld
  /opt/cm/share/cmf/schema/scm_prepare_database.sh mysql scm scm temp
fi

# check dir for k8s sa
echo "[+] $(date) fix k8s serviceaccount mount error"
if [ ! -d "/var/run/secrets/kubernetes.io/serviceaccount" ]; then
  mkdir -p /var/run/secrets/kubernetes.io/serviceaccount
fi

if [ ! -d "/run/secrets/kubernetes.io/serviceaccount" ]; then
  mkdir -p /run/secrets/kubernetes.io/serviceaccount
fi

# start server
echo "[+] $(date) start cloudera server"
/opt/cm/etc/init.d/cloudera-scm-server start

# start agent
echo "[+] $(date) start cloudera agent"
/opt/cm/etc/init.d/cloudera-scm-agent start

exit 0