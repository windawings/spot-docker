#!/bin/bash

# stop agent
/opt/cm/etc/init.d/cloudera-scm-agent stop
/opt/cm/etc/init.d/cloudera-scm-agent next_start_clean
/opt/cm/etc/init.d/cloudera-scm-agent next_stop_hard
rm -rf /opt/cm/run/cloudera-scm-agent/*

exit 0