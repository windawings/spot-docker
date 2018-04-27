#!/bin/bash

# clean agent
./stop.sh
rm -rf /opt/cm/etc/log/cloudera-scm-agent/*

# crontab
crontab /opt/cm/etc/cloudera-scm-agent/cron.tab

# start agent
/opt/cm/etc/init.d/cloudera-scm-agent start

# stop supervisor
systemctl stop supervisord
