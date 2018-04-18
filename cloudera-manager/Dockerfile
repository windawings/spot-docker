FROM windawings/cloudera-base
MAINTAINER windawings <windawings@foxmail.com>

# WorkDir Env
WORKDIR cloudera-init

# Compact Run Cammand
RUN echo -e "\nY\n$MYSQL_PASSWORD\n$MYSQL_PASSWORD\nY\nn\nY\nY\n" > mysql_secure_install_answer && \
    wget http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm && yum localinstall -y mysql57-community-release-el7-11.noarch.rpm && \
    yum install -y ntp \
                   mysql-community-server \
                   hive \
                   cloudera-manager-agent \
                   cloudera-manager-daemons \
                   cloudera-manager-server \
                   cloudera-manager-server-db-2 && \
    yum clean all && rm -rf /var/cache/yum/* && \
    pip install cm-api && \
    sed -i.bak s/^.*"hive-txn-schema-0.13.0.mysql.sql".*/"SOURCE \/usr\/lib\/hive\/scripts\/metastore\/upgrade\/mysql\/hive-txn-schema-0.13.0.mysql.sql;"/ /usr/lib/hive/scripts/metastore/upgrade/mysql/hive-schema-1.1.0.mysql.sql && \



# Config Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#start the supervisor
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
