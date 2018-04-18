FROM centos:7
MAINTAINER windawings <windawings@foxmail.com>

# Java ENV
ENV JAVA_HOME /usr/lib/jvm/java-openjdk

# Cloudera ENV
ENV CM_VER=5.14.2 CDH_VER=5.14.2

# MYSQL ENV
ENV MYSQL_PASSWORD=cloudera

# Compact Run Command
RUN yum makecache && yum -y update && yum -y upgrade && \
    yum install -y epel-release wget python-pip java-1.8.0-openjdk-devel mysql-connector-java openssl* && yum clean all && rm -rf /var/cache/yum/* && \
    pip install --upgrade pip && pip install supervisor && \
    wget http://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo && mv cloudera-cdh5.repo /etc/yum.repos.d && \
    wget http://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo && mv cloudera-manager.repo /etc/yum.repos.d && \
    sed -i.bak s/^.*"baseurl".*/"baseurl=http:\/\/archive.cloudera.com\/cdh5\/redhat\/7\/x86_64\/cdh\/$CDH_VER\/"/ /etc/yum.repos.d/cloudera-cdh5.repo && \
    sed -i.bak s/^.*"baseurl".*/"baseurl=http:\/\/archive.cloudera.com\/cm5\/redhat\/7\/x86_64\/cm\/$CM_VER\/"/ /etc/yum.repos.d/cloudera-manager.repo && \
    mkdir -p /etc/supervisor/conf.d/ && \
    mkdir cloudera-init && \
    ln -s /usr/share/java/mysql-connector-java.jar /usr/lib/hive/lib/mysql-connector-java.jar

# Config Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#start the supervisor
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
