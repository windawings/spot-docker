#!/bin/bash

# crontab
echo "[+] $(date) config ntp crontab task"
crontab /opt/cm/etc/cloudera-scm-agent/cron.tab

# init agent
echo "[+] $(date) init cloudera requirements"
echo 0 > /proc/sys/vm/swappiness
echo never > /sys/kernel/mm/transparent_hugepage/defrag
echo never > /sys/kernel/mm/transparent_hugepage/enabled

# stop agent
echo "[+] $(date) clean cloudera agent history"
bash /cloudera-init/run/stop.sh
rm -rf /opt/cm/etc/log/cloudera-scm-agent/*

# check dir for k8s sa
echo "[+] $(date) fix k8s serviceaccount mount error"
if [ ! -d "/run/secrets/kubernetes.io/serviceaccount" ]; then
  mkdir -p /run/secrets/kubernetes.io/serviceaccount
fi

if [ ! -d "/var/run/secrets/kubernetes.io/serviceaccount" ]; then
  mkdir -p /var/run/secrets/kubernetes.io/serviceaccount
fi

# start agent
echo "[+] $(date) start cloudera agent"
/opt/cm/etc/init.d/cloudera-scm-agent start

exit 0