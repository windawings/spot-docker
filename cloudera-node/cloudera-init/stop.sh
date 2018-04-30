#!/bin/bash

# stop agent
echo "[+] $(date) stop cloudera agent"
/opt/cm/etc/init.d/cloudera-scm-agent stop
/opt/cm/etc/init.d/cloudera-scm-agent next_start_clean
/opt/cm/etc/init.d/cloudera-scm-agent next_stop_hard

# clean agent
echo "[+] $(date) clean cloudera agent run dir"
rm -rf /opt/cm/run/cloudera-scm-agent/*

exit 0