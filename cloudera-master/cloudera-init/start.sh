#!/bin/bash

# check environment
if [ ! -n "$POD_NAME" ]; then
  echo "[-] $(date) invalid environment"
  exit 1
fi

# config hostname
echo "[+] $(date) config k8s hostname"

echo "[+] $(date) check k8s hostname file"
while [ ! -e /etc/hostname -o ! -e /etc/hosts ]; do
  echo "[-] $(date) hostname or hosts not found"
  sleep 2s
done

# try anything i can to update hostname, even though i open the port 4434 in service
if [ $(grep -c $HOSTNAME /etc/hostname) -eq 0 ]; then
  hostname $HOSTNAME
  echo $HOSTNAME > /etc/hostname
  hostnamectl set-hostname $HOSTNAME
fi

if [ ! -e /etc/sysconfig/network ]; then
  touch /etc/sysconfig/network
fi

if [ $(grep -c $HOSTNAME /etc/sysconfig/network) -eq 0 ]; then
  echo -e "HOSTNAME=${HOSTNAME}" >> /etc/sysconfig/network
fi

if [ $(grep -c $HOSTNAME /etc/hosts) -eq 0 ]; then
  sed -i "s/^$POD_IP.*$POD_NAME$/& $HOSTNAME/g" /etc/hosts
  echo "[+] $(date) reboot"
  shutdown -r now
fi

# check mysqld
echo "[+] $(date) check cloudera mysql"
while [ ! ps -ef | grep mysqld | egrep -v grep >/dev/null ]; do
  echo "[-] $(date) mysqld is not running"
  sleep 2s
done

# config mysql
if [ $(grep -c "character-set-server=utf8" /etc/my.cnf) -eq 0 ]; then
  echo "[+] $(date) config cloudera mysql"
  sed -i /^"\[mysqld\]"/a\\"character-set-server=utf8" /etc/my.cnf
  sed -i /^"\[mysqld\]"/a\\"skip-grant-tables" /etc/my.cnf
  systemctl restart mysqld
  mysql -u root < /cloudera-init/run/mysql.sql
  sed -i /^"skip-grant-tables/d" /etc/my.cnf
  systemctl restart mysqld
  /opt/cm/share/cmf/schema/scm_prepare_database.sh mysql scm scm temp
fi

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

# stop supervisor to avoid conflict with cloudera
echo "[+] $(date) stop supervisor"
systemctl stop supervisord

exit 0