#!/bin/bash

# stop agent
/opt/cm/etc/init.d/cloudera-scm-agent next_start_clean
/opt/cm/etc/init.d/cloudera-scm-agent next_stop_hard
systemctl stop cloudera-scm-agent
rm -rf /opt/cm/run/cloudera-scm-agent/*

exit 0