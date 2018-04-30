#!/bin/bash

# config hostname
echo "[+] $(date) config k8s hostname"
echo $HOSTNAME > /etc/hostname
if [ $(grep -c $HOSTNAME /etc/hosts) -eq 0 ]; then
  echo "${POD_IP} ${HOSTNAME}" >> /etc/hosts
  echo "[+] $(date) reboot"
  shutdown -r now
fi

# config mysql
echo "[+] $(date) config cloudera mysql"
sed -i /^"\[mysqld\]"/a\\"character-set-server=utf8" /etc/my.cnf
sed -i /^"\[mysqld\]"/a\\"skip-grant-tables" /etc/my.cnf
systemctl restart mysqld
mysql -u root < /cloudera-init/run/mysql.sql
sed -i /^"skip-grant-tables/d" /etc/my.cnf
systemctl restart mysqld
/opt/cm/share/cmf/schema/scm_prepare_database.sh mysql scm scm temp

# check dir for k8s sa
echo "[+] $(date) fix k8s serviceaccount mount error"
if [ ! -d "/run/secrets/kubernetes.io/serviceaccount" ]; then
  mkdir -p /run/secrets/kubernetes.io/serviceaccount
fi

if [ ! -d "/var/run/secrets/kubernetes.io/serviceaccount" ]; then
  mkdir -p /var/run/secrets/kubernetes.io/serviceaccount
fi

# start server
echo "[+] $(date) start cloudera server"
/opt/cm/etc/init.d/cloudera-scm-server start
exit 0