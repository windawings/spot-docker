#!/bin/bash

# crontab
crontab /opt/cm/etc/cloudera-scm-agent/cron.tab

# start agent
/opt/cm/etc/init.d/cloudera-scm-agent start

# clean agent
bash /cloudera-init/run/stop.sh
rm -rf /opt/cm/etc/log/cloudera-scm-agent/*

# restart agent
/opt/cm/etc/init.d/cloudera-scm-agent start
