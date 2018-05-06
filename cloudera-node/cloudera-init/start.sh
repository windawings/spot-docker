#!/bin/bash

# crontab
echo "[+] $(date) config crontab ntp task"
crontab /opt/cm/etc/cloudera-scm-agent/cron.tab

# init agent system requirements
echo "[+] $(date) init cloudera requirements"
echo 0 > /proc/sys/vm/swappiness
echo never > /sys/kernel/mm/transparent_hugepage/defrag
echo never > /sys/kernel/mm/transparent_hugepage/enabled

# stop and clean agent
echo "[+] $(date) clean cloudera agent history"
bash /cloudera-init/run/stop.sh
rm -rf /opt/cm/etc/log/cloudera-scm-agent/*
mkdir -p /var/lib/alternatives/

# check dir for k8s sa
echo "[+] $(date) fix k8s serviceaccount mount error"
if [ ! -d "/var/run/secrets/kubernetes.io/serviceaccount" ]; then
  mkdir -p /var/run/secrets/kubernetes.io/serviceaccount
fi

if [ ! -d "/run/secrets/kubernetes.io/serviceaccount" ]; then
  mkdir -p /run/secrets/kubernetes.io/serviceaccount
fi

# start agent
echo "[+] $(date) start cloudera agent"
/opt/cm/etc/init.d/cloudera-scm-agent start

exit 0