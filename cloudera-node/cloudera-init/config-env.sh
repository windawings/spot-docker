#!/bin/bash

# yum install
yum -q -y update && yum -q -y upgrade
yum -q -y install epel-release wget ntp openssh*
yum -q -y install python-pip python-devel rpcbind crontabs which psmisc MySQL-python at bc bind-libs bind-utils cups-client cups-libs cyrus-sasl-gssapi cyrus-sasl-plain ed fuse fuse-libs httpd httpd-tools keyutils-libs-devel krb5-devel libcom_err-devel libselinux-devel libsepol-devel libverto-devel mailcap noarch mailx mod_ssl openssl-devel pcre-devel postgresql-libs python-psycopg2 redhat-lsb-core redhat-lsb-submod-security x86_64 spax time zlib-devel bsdtar

# set bsdtar instead of tar
cp $(which tar) $(which tar)~
ln -sf $(which bsdtar) $(which tar)

# install jdk
wget -q --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.rpm -O jdk.rpm
rpm -i jdk.rpm
wget -q http://central.maven.org/maven2/mysql/mysql-connector-java/5.1.46/mysql-connector-java-5.1.46.jar -O mysql-connector-java.jar
mv mysql-connector-java.jar /usr/java/latest/

# install cloudera
wget -q http://archive.cloudera.com/cm5/cm/5/cloudera-manager-centos7-cm5.14.2_x86_64.tar.gz -O cm.tar.gz
tar zxf cm.tar.gz -C /opt/
mv /opt/cm-5.14.2 /opt/cm
sed -i s/^.*"cloudera_mysql_connector_jar".*/"cloudera_mysql_connector_jar=\/usr\/java\/latest\/mysql-connector-java.jar"/ /opt/cm/etc/cloudera-scm-agent/config.ini

# install supervisor
pip install -q --upgrade pip

# config centos
chmod 755 /cloudera-init/run/cloudera-init
chmod +x /etc/rc.d/rc.local
echo "echo 0 > /proc/sys/vm/swappiness" >> /etc/rc.d/rc.local
echo "echo never > /sys/kernel/mm/transparent_hugepage/defrag" >> /etc/rc.d/rc.local
echo "echo never > /sys/kernel/mm/transparent_hugepage/enabled" >> /etc/rc.d/rc.local
echo 0 > /proc/sys/vm/swappiness
echo never > /sys/kernel/mm/transparent_hugepage/defrag
echo never > /sys/kernel/mm/transparent_hugepage/enabled
mv /cloudera-init/run/functions /etc/init.d/
mv /cloudera-init/run/cloudera-init /etc/init.d/

# ssh login without authetication
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
sed -i s/^"#PermitRootLogin yes"/"PermitRootLogin yes"/ /etc/ssh/sshd_config
sed -i /^"PermitRootLogin yes"/a\\"RSAAuthentication yes" /etc/ssh/sshd_config
sed -i s/^"PasswordAuthentication yes"/"PasswordAuthentication no"/ /etc/ssh/sshd_config
sed -i s/^"#PubkeyAuthentication yes"/"PubkeyAuthentication yes"/ /etc/ssh/sshd_config
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

# config ntp
echo "server s1a.time.edu.cn prefer" >> /etc/ntp.conf

# config user group
useradd --system --home=/opt/cm/run/cloudera-scm-server  --shell=/bin/false --comment "Cloudera SCM User" cloudera-scm

# create dir
mkdir -p /cloudera-init/log/
mkdir -p /var/lib/alternatives/
mkdir -p /opt/cloudera/parcels/.flood
mkdir -p /var/lib/cloudera-scm-server/
mkdir -p /opt/cm/run/cloudera-scm-agent/
mkdir -p /run/secrets/kubernetes.io/serviceaccount/
mkdir -p /var/run/secrets/kubernetes.io/serviceaccount/

# config dir
chmod 751 /opt/cm/run/cloudera-scm-agent/
chmod 755 /opt/cloudera/parcels/.flood/
chown cloudera-scm:cloudera-scm /opt/cloudera/parcels/.flood/ /var/lib/cloudera-scm-server/

# config autostart
chkconfig sshd on
chkconfig crond on
chkconfig rpcbind on
chkconfig cloudera-init on

# clean
yum clean all
yum -q -y remove wget
rm -rf /var/cache/yum/*
rm -f jdk.rpm cm.tar.gz /cloudera-init/run/config-env.sh