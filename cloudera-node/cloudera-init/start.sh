#!/bin/bash

# clean agent
./stop.sh
rm -rf /opt/cm/etc/log/cloudera-scm-agent/*

# crontab
crontab /opt/cm/etc/cloudera-scm-agent/cron.tab

# stop supervisor
systemctl stop supervisord &

# start agent
/opt/cm/etc/init.d/cloudera-scm-agent start
