FROM centos:7
MAINTAINER windawings <windawings@foxmail.com>

# yum
RUN yum makecache && yum -y update && yum -y upgrade
RUN yum install -y epel-release wget && yum clean all && rm -rf /var/cache/yum/*

# Java ENV
ENV JAVA_HOME /usr/lib/jvm/java-openjdk

# Cloudera ENV
ENV CM_VERSION=5.14.2 CDH_VERSION=5.14.2
RUN wget http://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/cloudera-cdh5.repo && mv cloudera-cdh5.repo /etc/yum.repos.d && \
    wget http://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo && mv cloudera-manager.repo /etc/yum.repos.d && \
    sed -i.bak s/^.*"baseurl".*/"baseurl=http:\/\/archive.cloudera.com\/cdh5\/redhat\/7\/x86_64\/cdh\/$CDH_VERSION\/"/ /etc/yum.repos.d/cloudera-cdh5.repo && \
    sed -i.bak s/^.*"baseurl".*/"baseurl=http:\/\/archive.cloudera.com\/cm5\/redhat\/7\/x86_64\/cm\/$CM_VERSION\/"/ /etc/yum.repos.d/cloudera-manager.repo

# MYSQL ENV
ENV MYSQL_PASSWORD=cloudera

CMD ["bash"]
