#!/bin/bash

# stop server
echo "[+] $(data) stop cloudera server"
/opt/cm/etc/init.d/cloudera-scm-server stop

exit 0