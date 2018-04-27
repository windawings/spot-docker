#!/bin/bash

# clean agent
./stop.sh
rm -rf /opt/cm/etc/log/cloudera-scm-agent/*

# start agent
/opt/cm/etc/init.d/cloudera-scm-agent start