#!/bin/bash

# crontab
crontab /opt/cm/etc/cloudera-scm-agent/cron.tab

# start agent
/opt/cm/etc/init.d/cloudera-scm-agent start

# clean agent
echo 0 > /proc/sys/vm/swappiness
echo never > /sys/kernel/mm/transparent_hugepage/defrag
echo never > /sys/kernel/mm/transparent_hugepage/enabled
bash /cloudera-init/run/stop.sh
rm -rf /opt/cm/etc/log/cloudera-scm-agent/*

# check dir for k8s sa
if [ ! -d "/run/secrets/kubernetes.io/serviceaccount" ]; then
  mkdir -p /run/secrets/kubernetes.io/serviceaccount
fi

if [ ! -d "/var/run/secrets/kubernetes.io/serviceaccount" ]; then
  mkdir -p /var/run/secrets/kubernetes.io/serviceaccount
fi

# restart agent
/opt/cm/etc/init.d/cloudera-scm-agent start

exit 0