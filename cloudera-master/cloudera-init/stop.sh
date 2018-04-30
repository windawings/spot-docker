#!/bin/bash

# stop server
echo "[+] $(date) stop cloudera server"
/opt/cm/etc/init.d/cloudera-scm-server stop

exit 0